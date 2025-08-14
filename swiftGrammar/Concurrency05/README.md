# Isolation & @MainActor

- **데이터 격리(data isolation)**

    - 동시 접근을 막아 **data race** 방지

    ---

- Main Actor

    - UI 데이터와 UI 업데이트 코드 전담

    - 사실상 *"UI 전용 직렬 큐"* 역할

    - Main Thread와 개념은 다르지만 대부분 같이 동작

---

## Isolation

> 이러한 작업에는 앱의 UI처럼 공유 데이터를 변경하는 일이 포함될 수 있음

> 만약 코드의 서로 다른 부분이 동시에 같은 데이터를 수정할 수 있다면,
**data race** 위험이 생김

- Swift는 **data race** 를 방지해주는 데 이를 **데이터 격리(data isolation)** 라고 부릅

- 즉, 어떤 data를 읽거나 수정하려고 할 때, Swift는 다른 코드가 동시에 그 data를 수정하지 못하도록 보장함

## Swift에서 데이터를 isolation 하는 방법

1. **불변 데이터(Immutable data)**

    - *Immutable data* 는 항상 격리되어 있음

    - *상수* 는 수정할 수 없으므로, 다른 코드가 동시에 수정할 위험이 없음

    ---

2. **현재 작업(Task)에서만 참조하는 데이터**

    - *로컬 변수* 는 현재 작업 안에서만 접근되므로 안전

    - 다른 task가 그 메모리에 접근할 수 없으니 동시 수정이 불가능

    - 변수를 클로저에 캡처하더라도 Swift는 그 클로저가 동시에 사용되지 않도록 보장함

    ---

3. **`Actor`로 보호된 데이터**

    - 어떤 데이터가 `Actor`로 보호되고, 해당 데이터에 접근하는 코드도 같은 `Actor`에 속해 있다면, 안전하게 **Read/Write** 가능

    - 같은 `Actor` 에 속한 다른 코드도 순서를 기다려야 하므로 동시 접근이 없음

---

## The Main Actor

> 앱에서 가장 중요한 Actor는 `Main Actor`

Actor는 **mutable data** 에 접근할 때 차례로만 접근하게 해서
데이터를 보호하는 객체

- **UI를 표시하는 모든 데이터는 `Main Actor`가 보호**

- `Main Actor`는 UI 렌더링, UI 이벤트 처리, 그리고 UI를 업데이트하는 코드를 차례대로 실행

- Concurrency를 쓰기 전에는 모든 코드가 `Main Actor`에서 실행됨
그러다 오래 걸리거나 리소스를 많이 쓰는 코드를 찾으면,

    - 그 task 만 Main Actor 밖에서 안전하게 실행할 수 있음

*cf. `Main Actor`와 `Main Thread`는 비슷하지만 동일하지 않음*

- `Main Actor` 는 자기만의 가변 상태를 가지고 있고,

- `Main Thread` 는 이 상태 접근을 직렬화함

- `Main Actor` 에서 실행되는 코드는 `Main Thread` 에서 실행되지만,

- `Main Thread`는 더 저수준의 구현 세부사항임

---

### Main Actor에서 함수 실행하기

> 특정 함수를 항상 Main Actor에서 실행하도록 하려면 `@MainActor` 속성을 붙임

```swift
@MainActor
func show(_: Data) {
    // UI 코드
}
```

- Main Actor 안에서 `show(_:)` 를 호출하면 **synchronous** 호출 가능

- Main Actor 밖에서 호출하려면 `await` 필요

    - Main Actor로 전환하는 과정에서 **suspension point** 발생 가능성 때문

    ---

```swift
func downloadAndShowPhoto(named name: String) async {
    let photo = await downloadPhoto(named: name)
    await show(photo)
}
```

여기서 `downloadPhoto`와 `show` 모두 **중단(suspend)** 가능

- 네트워크 같은 오래 걸리는 작업은 Main Actor 밖에서 실행

- UI 업데이트는 Main Actor에서 실행


---

### Main Actor에서 클로저 실행하기

```swift
let photo = await downloadPhoto(named: "Trees at Sunrise")
Task { @MainActor in
    show(photo)
}
```

- 이렇게 하면 UI 업데이트를 기다리지 않고 실행 가능

---

### Type 전체를 Main Actor로 보호하기

```swift
@MainActor
struct PhotoGallery {
    var photoNames: [String]
    func drawUI() { /* UI 코드 */ }
}
```

- `photoNames` 가 UI에 영향을 주므로 Main Actor에서만 변경 가능

---

### 프레임워크에서의 @MainActor

```swift
@MainActor
protocol View { }

struct PhotoGalleryView: View { }
```

- **SwiftUI** 같은 프레임워크는 `View` **프로토콜** 자체에 `@MainActor` 를 적용

- 이를 채택하는 타입도 자동으로 Main Actor 적용

---

### 부분 적용

```swift
struct PhotoGallery {
    @MainActor var photoNames: [String]
    var hasCachedPhotos = false

    @MainActor func drawUI() { /* UI 코드 */ }
    func cachePhotos() { /* 네트워크 코드 */ }
}
```

- `photoNames`와 `drawUI()` -> UI 관련 -> Main Actor 필요

- `hasCachedPhotos` 와 `cachePhotos()` -> UI와 무관 -> Main Actor 불필요

---

## 참고

- [공식문서: Concurrency - Isolation](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Isolation)

- [공식문서: Concurrency - The Main Actor](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#The-Main-Actor)