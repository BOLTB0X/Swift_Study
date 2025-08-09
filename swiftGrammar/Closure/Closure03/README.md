# `@Escaping` Closures

> A closure is said to escape a function when the closure is passed as an argument to the function,

> but is called after the function returns.

- 함수에 매개변수로 전달되었지만, **함수가 끝난 이후에 실행될 수 있는 클로저**

- 매개변수 타입 앞에 `@escaping` 을 붙여서 사용

- 보통 비동기 작업이나 **콜백(completion handler)** 에서 사용

---

## 주로 사용하는 case

### 1. `completionHandler`

```swift
var completionHandlers: [() -> Void] = []

func someFuncWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
```

- `completionHandler` 는 함수 안에서 바로 실행되지 않음

- 외부 배열 `completionHandlers` 에 저장되므로, 함수가 끝나도 나중에 실행 가능 -> **"escapes"**

---

### 2. 상수에 클로저를 대입하는 경우

```swift
func someThingFunc(closure: () -> ()) {
    let constant : () -> () = closure // non-escaping parameter 에러
}
```

- 함수 내부에서 직접 실행하기 위해서만 사용했는데 파라미터로 받은 클로저를 변수나 상수에 대입 X

```swift
func someThingFunc(closure: @escaping () -> ()) {
    let constant: () -> () = closure
}
```

---

### 3. 함수 실행 흐름에서 `@escaping` 하지 않은 경우

```swift
func sampleFunction(closure: () -> ()) {
    print("함수 시작")

    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {// Escaping closure captures non-escaping parameter
        closure()
    }
    print("함수 종료")
}
```

- 함수가 끝나고 클로저가 실행되기 때문에 에러 -> **함수가 종료되고 나서 클로저가 실행될 수 X**

---

### 4. 중첩함수 내부에 파라미타로 받은 클로저를 사용할 경우

```swift
func outFunc(closure: () -> ()) -> () -> () {
    func localFunc() {
        closure()
    }

    return inFunc() // Escaping local function cpatures non-escaping parameter 'closure'
}
```

- 중첩합수를 리턴 X

```swift
func outFunc(closure: @escaping () -> ()) -> () -> () {
    func localFunc() {
        closure()
    }

    return inFunc()
}
```

---

## Nonescaping Closure

- 기본 클로저 매개변수는 `@escaping`이 없으면 함수 내부에서만 실행 가능

- 함수가 끝나면 클로저 참조도 사라짐

- 클로저가 즉시 실행되므로 **non-escaping**

    ```swift
    func someFunctionWithNonescapingClosure(closure: () -> Void) {
        closure()
    }
    ```

---

## `self` 캡처 차이

```swift
class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 } // self 명시
        someFunctionWithNonescapingClosure { x = 200 }   // self 생략 가능
    }
}
```

- `@escaping` 클로저에서 `self` 를 사용할 때는 명시적으로 `self`를 명시

- `@escaping 클로저` 는 인스턴스를 오래 붙잡을 수 있어서 **강한 참조 순환(Strong Reference Cycle)** 위험이 있기 때문

```swift
let instance = SomeClass()
instance.doSomething()
print(instance.x)           // 200 (non-escaping이 먼저 실행)
completionHandlers.first?() // 100 (escaping이 나중에 실행)
print(instance.x)
```

- **Capture List** 로 `self` 처리

    ```swift
    someFunctionWithEscapingClosure { [self] in x = 100 }
    ```

    - `self` 를 매번 쓰기 싫다면 `[self]` 로 **캡처 리스트** 사용


---

## `Struct` 와 `Enum` 에서는 제한

```swift
struct SomeStruct {
    var x = 10
    mutating func doSomething() {
        someFunctionWithNonescapingClosure { x = 200 } // OK
        someFunctionWithEscapingClosure { x = 100 }    // Error
    }
}
```

- escaping 클로저에서 `mutable` `self` 를 캡처할 수 없음.

- Swift의 값 타입은 공유 가능한 가변 참조를 허용하지 않음

---


## 참고

[공식문서 - Escaping-Closures](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/#Escaping-Closures)

[블로그 참고 - 클로저(Closure) 정복하기(2/3) - 문법 경량화 / @escaping / @autoclosure(개발자 소들이)](https://babbab2.tistory.com/82?category=828998)

