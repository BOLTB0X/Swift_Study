# Actors

> Actors, Global Actors, Sendable에 대한 공식 문서

| 개념           | 설명                                  | 키포인트                           |
| ------------ | ----------------------------------- | ------------------------------ |
| Actor        | 안전하게 동시 접근 방지하는 참조 타입               | `await`로 접근, 내부에서는 `await` 불필요 |
| Global Actor | 전역 단일 Actor (예: MainActor)          | UI 코드 실행 보장                    |
| `Sendable`     | 안전하게 concurrency domain 간 전달 가능한 타입 | 구조체는 보통 자동 Sendable            |
| `~Sendable`   | Sendable 아님 표시                      | 의도적 제한                         |


---

## Actors

> Swift에서 Actor는 안전하게 공유 데이터를 다루기 위한 참조 타입

```swift
protocol Actor : AnyObject, Sendable
```

- 클래스(`class`)처럼 참조 타입

- 동시에 오직 하나의 **Task** 만이 **Actor** 의 **변경 가능한 상태(mutable state)** 에 접근 가능

    - 이렇게 하면 데이터 레이스를 방지 가능

    ---

```swift
actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int
    
    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}
```

- `actor` 키워드로 선언

- 외부에서도 읽을 수 있는 `max` 지만, 수정은 **Actor** 내부에서만 가능 (`private(set)`)

- **Actor** 의 프로퍼티나 메서드에 외부에서 접근할 때는 `await` 필요

```swift
let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
print(await logger.max) // suspension point
```

```
25
Playground execution failed:

error: execution stopped with unexpected state.
error: Execution was interrupted.
The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation.
```

- 이유: **Actor** 의 상태 접근은 **잠재적 suspension point** 이기 때문

- 다른 **Task** 가 이미 해당 **Actor** 에 접근 중이면, **대기(`await`)하다가 차례가 오면 실행**

---

## Actor 내부에서는 `await` 불필요

Actor 내부 메서드는 이미 Actor의 **격리 영역(isolation)** 안에 있으므로

동일 Actor의 상태 접근에 `await`를 쓰지 않아도 됌

```swift
extension TemperatureLogger {
    func update(with measurement: Int) {
        measurements.append(measurement)
        if measurement > max {
            max = measurement
        }
    }
}
```

- `update` 메서드 실행 중에는 다른 Task가 끼어들 수 없음

    - 이유: `await`가 없어서 **suspension point** 가 없기 때문

- 이렇게 하면 **데이터 일관성(invariance)** 유지 가능

---

## Global Actors

- `MainActor`는 전역 단일 인스턴스 Singleton

- 보통 UI 관련 코드는 `@MainActor`로 실행 -> 항상 메인 스레드에서 동작 보장

- 자신만의 Global Actor도 만들 수 있음 (`@globalActor`)

---

## Sendable

```swift
protocol Sendable : SendableMetatype
```

**Concurrency Domain(동시성 영역)** 간에 안전하게 전달할 수 있는 타입

- `Sendable` 프로토콜을 채택

- **값 타입(value type)** 이고 내부가 `Sendable`이면 자동으로 `Sendable`

- 클래스라도 `@MainActor` 나 적절한 동기화가 있으면 `Sendable` 가능

```swift
struct TemperatureReading: Sendable {
    var measurement: Int
}
```

- Task나 Actor 사이에서 데이터를 안전하게 주고받을 수 있음

```swift
struct FileDescriptor: ~Sendable {
    let rawValue: Int
}
```

- `~Sendable` 은 반대로 *"이 타입은 Sendable이 아님"* 을 표시

```swift
extension TemperatureLogger {
    func addReading(from reading: TemperatureReading) {
        measurements.append(reading.measurement)
    }
}
```

```swift
let logger = TemperatureLogger(label: "Tea kettle", measurement: 85)
let reading = TemperatureReading(measurement: 45)
await logger.addReading(from: reading)
```

---

## 참고

- [공식문서: Concurrency - Actors](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Actors)

- [공식문서 - actor](https://developer.apple.com/documentation/swift/actor)

- [공식문서 - sendable](https://developer.apple.com/documentation/swift/sendable)