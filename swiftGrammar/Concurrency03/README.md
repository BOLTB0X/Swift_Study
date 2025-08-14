# Sequential 와 Parallel

- `for await-in` : *한 개씩 천천히 도착하는 데이터를 기다렸다가 처리*

- `await` : *“첫 번째 라면 끓여서 먹고, 다 먹으면 두 번째 라면 끓이고…”*

- `async let` : *“3개 라면 냄비를 동시에 불 올려놓고, 다 익을 때까지 기다렸다가 한 번에 먹는 것”*

---

## Asynchronous Sequences

> 비동기 시퀀스를 사용하여 컬렉션의 한 요소씩 기다리는 것

비동기 시퀀스를 반복하는 방법은 다음과 같음

```swift
let handle = FileHandle.standardInput
for try await line in handle.bytes.lines {
    print(line)
}
```

- 일반적인 `for-in` 루프를 사용하는 대신, 위 예제에서는 `for` 뒤에 `await` 를 붙임

- 비동기 함수나 메서드를 호출할 때처럼 `await` 를 쓰는 것은 잠재적인 **일시 중단 지점** 을 나타냄

- `for-await-in` 루프는 각 반복의 시작 부분에서 다음 요소가 사용 가능할 때까지 대기할 때 실행을 일시 중단할 가능성이 있음

```swift
protocol Sequence<Element>
```

- `Sequence` 프로토콜에 적합성을 추가하여 `for-in` 루프에서 사용자 정의 타입을 사용할 수 있는 것과 마찬가지로,

```swift
protocol AsyncSequence<Element, Failure>
```

- `AsyncSequenc`e 프로토콜에 적합성을 추가하여 `for-await-in` 루프에서 사용자 정의 타입을 사용할 수 있음

---

## Calling Asynchronous Functions in Parallel

### `await` : 순차 실행 (Sequential)

```swift
let firstPhoto = await downloadPhoto(named: photoNames[0])
let secondPhoto = await downloadPhoto(named: photoNames[1])
let thirdPhoto = await downloadPhoto(named: photoNames[2])

show([firstPhoto, secondPhoto, thirdPhoto])
```

- **흐름:**

    1. 첫 번째 사진 다운로드 시작 → 완료까지 기다림

    2. 두 번째 사진 다운로드 시작 → 완료까지 기다림

    3. 세 번째 사진 다운로드 시작 → 완료까지 기다림

    ---

- **즉, 각 다운로드가 앞선 작업이 끝나야 다음이 시작됨**

- **모든 다운로드를 합치면 걸리는 시간 ≈ (다운로드 시간 × 3)**

- **단점** : **다운로드가 비동기식이고 진행되는 동안 다른 작업이 수행될 수 있지만 `downloadPhoto(named:)`에 대한 호출은 한 번에 하나만 실행된다는 점**


---

### `async let` : 병렬 실행 (Parallel)

> **병렬로 async함수 호출 방법은 `async let` 키워드로 선언**


```swift
async let firstPhoto = downloadPhoto(named: photoNames[0])
async let secondPhoto = downloadPhoto(named: photoNames[1])
async let thirdPhoto = downloadPhoto(named: photoNames[2])

let photos = await [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
```

- **흐름:**

    1. 세 개의 다운로드를 거의 동시에 시작

    2. 결과가 필요할 때 (`await [firstPhoto, secondPhoto, thirdPhoto]` )까지는 대기하지 않음

    3. 마지막에 한 번에 결과를 기다림

- 걸리는 시간 ≈ (가장 오래 걸리는 다운로드 시간)

---

| 방식          | 시작 시점   | 기다림 시점  | 실행 속성 |
| ----------- | ------- | ------- | ----- |
| `await`     | 호출 즉시   | 그 자리에서  | 순차 실행 |
| `async let` | 변수 선언 시 | 결과 필요 시 | 병렬 실행 |

---

## 참고

- [공식문서: Concurrency](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Asynchronous-Sequences)
