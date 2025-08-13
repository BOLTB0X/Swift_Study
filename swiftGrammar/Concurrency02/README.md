# Defining and Calling Asynchronous Functions

> 비동기 함수 또는 비동기 메서드는 실행 도중에 일시 중단될 수 있는 특수한 종류의 함수 또는 메서드

- 완료될 때까지 실행되거나, 오류를 발생시키거나, 반환하지 않는 일반적인 동기 함수 및 메서드와 대조 됌

- 비동기 함수 또는 메서드는 이 세 가지 중 하나를 수행하지만, 무언가를 기다리는 동안 중간에 일시 중단될 수도 있음

- 비동기 함수 또는 메서드 본문 내에서 실행을 일시 중단할 수 있는 이러한 각 위치를 표시

## Intro

> Swift의 언어 지원을 사용하지 않고도 동시성 코드를 작성할 수 있지만, 해당 코드이 낮음

*ex 다음 코드는 사진 이름 목록을 다운로드하고, 그 목록의 첫 번째 사진을 다운로드하여 사용자에게 보여주는 코드*

```swift
listPhotos(inGallery: "Summer Vacation") { photoNames in
    let sortedNames = photoNames.sorted()
    let name = sortedNames[0]
    
    downloadPhoto(named: name) { photo in
        show(photo)
    }
}
```

```swift
// MARK: - Completion Handler 기반 메서드
func listPhotos(inGallery name: String, completion: @escaping ([String]) -> Void) {
    print("'\(name)' 갤러리에서 사진 목록 가져오는 중...")
    DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
        completion(["IMG001", "IMG099", "IMG0404"])
    }
}

func downloadPhoto(named name: String, completion: @escaping (String) -> Void) {
    print("'\(name)' 다운로드 중...")
    DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
        completion("\(name) 데이터")
    }
}

func show(_ photo: String) {
    print("사진 표시: \(photo)")
}
```

---

## `async` , `await`

### `async` : 비동기 함수임을 나타내는 키워드

```swift
func listPhotos(inGallery name: String) async -> [String]
```

- 함수 또는 메서드가 비동기임을 나타내려면 선언 시 매개변수 뒤에 `async` 키워드를 작성

    - `throws` 를 사용하여 `throw` 함수를 표시하는 방식과 유사

- 함수 또는 메서드가 값을 반환하는 경우, **반환 화살표(`->`)** 앞에 `async` 를 작성

---

### `await` : `async` 키워드가 표시된 메소드나 함수의 리턴을 기다림

> 비동기 메서드를 호출하면 해당 메서드가 반환될 때까지 실행이 일시 중단됌

```swift
let photoNames = await listPhotos(inGallery: "Summer Vacation")
```

- 호출 앞에 `await` 를 사용하여 일시 중단 지점을 표시

    - 이는 `throw` 함수를 호출할 때 `try` 를 사용하여 오류 발생 시 프로그램 흐름이 변경될 가능성을 표시하는 것과 같음
    
- 비동기 메서드 내에서는 다른 비동기 메서드를 호출할 때만 실행 흐름이 일시 중단 가능

---

```swift
func listPhotos(inGallery name: String) async -> [String] {
    let result = // ... some asynchronous networking code ...
    return result
}
```

- `listPhotos`와 `downloadPhoto`는 네트워크 요청처럼 시간이 오래 걸릴 수 있는 비동기 작업들

- **Swift** 에서는 이런 작업 앞에 `async` 키워드를 붙이고, 호출하는 쪽에서는 `await` 를 사용


```swift
let photoNames = await listPhotos(inGallery: "Summer Vacation")
let sortedNames = photoNames.sorted()
let name = sortedNames[0]
let photo = await downloadPhoto(named: name)
show(photo)
```

1. **첫 번째 `await` 전까지 쭉 실행**

    - `let photoNames = await listPhotos(...)` 를 만나기 전까지 실행이 계속 이어짐

    ---

2. **첫 번째 `await` 에서 멈춤**

    - `listPhotos(...)` 호출 시 이 함수가 끝날 때까지 현재 함수 실행을 잠시 중단
    
    - **suspension point** (실행 일시정지 지점)

    ---

3. **대기하는 동안 다른 코드 실행 가능**

    - ex, 백그라운드에서 다른 갤러리 목록 업데이트 같은 작업이 돌 수 있음
    
    ---

4. **`listPhotos` 완료 후 재개**

    - `photoNames`에 결과가 들어오고, 다음 줄인 `sortedNames` 와 `name` 을 정하는 코드 실행
    
    - 여기엔 `await` 가 없으니 순수 동기 실행

    ---

5. **두 번째 `await`에서 또 멈춤**

    - `await downloadPhoto(...)` 에서 다시 실행을 잠시 중단하고 다른 코드가 실행될 기회를 줌

    ---

6. **다시 재개 후 `show` 호출**

    - 다운로드 결과를 `photo` 에 넣고, `show(photo)` 실행

---

## suspension point(중단 지점)의 의미

- `await` 는 “이 함수가 끝날 때까지 기다린다”가 아니라,
    **"이 시점에서 실행을 중단하고, 다른 코드가 실행될 수 있도록 스레드를 양보한다"** 에 가까움

- Swift 런타임이 알아서 이어서 실행해야 할 지점을 기억해 둠

- 이런 것을 **“thread yielding” (스레드 양보)** 이라고 불림

---

## `async` 함수를 호출할 수 있는 곳

> `async` 함수는 오직 다음에서만 호출 가능

- 다른 `async` 함수/메서드/프로퍼티 안

- `@main`이 붙은 타입의 `static main()` 안

- 비구조적 `Task { ... }` 안

즉, 동기 코드에서 바로 `async` 함수를 부를 수는 없음

---


## suspend(중지)/resume(재개) 필요성

> swift의 모든 비동기 함수는 여러 **task** 의 집합으로 이루어짐, 비동기 함수가 다른 비동기 함수를 호출했을 때, 해당 호출 또한 **task** 라고 할 수 있음

- **task** 는 동기 함수에서 스레드 내 함수 컨텍스트에 해당하는 `continuation`을 포함하며 `continuation`은 **task** 가 `suspend(중지)` 되었을 때 발생하며,


- `resume(재개)` 될 때 이를 이용해 **suspension point(중지 지점)** 로 돌아가는 것이 가능

---

## suspend -> resume의 과정

1. `await` 키워드를 만나면 **suspension point** 로 지정하고 일시정지 (suspend)

2. 스레드의 제어권을 시스템에게 넘겨줌


3. 시스템이 다시 비동기 함수에게 스레드 제어권을 넘겨줌


4. **suspension point** 에서 작업 재개 (`resume`)

---

## `throws` 와 `async` 의 비교

- `throws` :

    - 동기 코드에서도 `do-catch` 로 감싸거나 `Result` 로 에러를 처리 가능

- `async` :

    - 동기 코드에서 호출 불가

    - `async` 호출하려면 그 호출부 자체가 `async` 여야 함

    - 강제로 동기 호출하게 만드는 기능은 Swift 표준 라이브러리에 의도적으로 없음 (데드락 위험)

    ---

```swift
// Task.sleep(for:tolerance:clock:)
func listPhotos(inGallery name: String) async throws -> [String] {
    try await Task.sleep(for: .seconds(2))
    return ["IMG001", "IMG99", "IMG0404"]
}
```

- `Task.sleep`이 `throws` 인 이유: 취소 시 에러를 던질 수 있어서

```swift
let photos = try await listPhotos(inGallery: "A Rainy Weekend")
```

- `try` 와 `await` 를 동시에 써야 함

```swift
func riskyFunction() throws -> Int {
    return Int.random(in: 0...1) == 0 ? 42 : { throw NSError(domain: "Fail", code: 1) }()
}

func safeWrapper() -> Result<Int, Error> {
    return Result {
        try riskyFunction()
    }
}

print(safeWrapper()) 
// 성공: .success(42)
// 실패: .failure(Error)
```

1. **`throws` 는 동기 코드에서도 호출 가능하게 만들 수 있음**

    - `do-catch` 나 `Result`로 감싸서

    -  동기 코드에서도 예외를 “포착”해서 호출 가능

    -  즉, `throws`는 동기 코드 → `throws` 함수 호출이 가능함

    ---

```swift
func asyncFunction() async -> Int {
    return 42
}

func syncFunction() {
    let value = asyncFunction() // 에러
}
```

2. **`async` 는 동기 코드에서 호출 불가**

    - Swift 표준 라이브러리에서 "동기에서 `async` 호출을 기다리는 기능"을 일부러 뺌

    - 잠재적인 데드락

    - 스레드 블로킹

    - 특히 UI 스레드(Main thread)에서 동기 대기 시 앱이 멈출 수 있음

    ---

3. **왜 top-down 방식이 필요한가?**

    - 앱의 가장 상위 진입점 (예: `@main` , `ViewModel` 메서드 등)을 async로 바꿈

    - 그 함수가 호출하는 하위 함수들도 `async` 로 변환


    - **bottom-up 불가:**

        동기 함수는 `async` 함수를 호출할 수 없으니, 아래부터 `async`로 바꿔도 쓸 수 없음

    - **top-down만 가능:**

        상위에서 `async` 를 쓰게 하면 하위도 자연스럽게     `async` 사용 가능

---

## 참고

- [공식문서: Concurrency](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Calling-Asynchronous-Functions-in-Parallel)

- [Swift concurrency: Behind the scenes](https://developer.apple.com/videos/play/wwdc2021/10254/)

- [김종권의 iOS](https://ios-development.tistory.com/589)