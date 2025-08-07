# Closure Expressions

> **Swift** 에서 클로저는 3가지 형태로 존재

| 형태                     | 설명             | 캡처 가능 여부 |
| ---------------------- | -------------- | -------- |
| **Global function**    | 전역 함수 (`func`) | 캡처 불가  |
| **Nested function**    | 함수 안의 함수       | 캡처 가능  |
| **Closure expression** | 익명 인라인 클로저  | 캡처 가능  |

```swift
// 노익명함수
func Hello() {
    print("Hello Closure")
}
```

```swift
// 익명함수
let Hello = { print("Hello Closure") }
// 일반적인 Closure 라고 하면 Unnamed Closure
```

- *Nested functions* 을 좀 더 간결하고 유용하게 표현하는 것이 **Closure**

- 정의된 **컨텍스트** 에서 모든 상수와 변수에 대한 **참조** 를 **캡처** 하고 저장할 수 있음

---

## ex) Sorted Method

~~점점 간결하게 만드는 예시를 공식문서에서 보여줌~~

1. **일반 함수 사용**

   ```swift
   func backward(_ s1: String, _ s2: String) -> Bool {
      return s1 > s2
   }
   names.sorted(by: backward)
   ```

   ---

2. **클로저 표현식**

   ```swift
   names.sorted(by: { (s1: String, s2: String) -> Bool in
      return s1 > s2
   })
   ```

   ---

3. **타입 생략**

   ```swift
   names.sorted(by: { s1, s2 in return s1 > s2 })
   ```

   ---

4. **암시적 리턴**

   ```swift
   names.sorted(by: { s1, s2 in s1 > s2 })
   ```

   ---

5. **축약 인자**

   ```swift
   names.sorted(by: { $0 > $1 })
   ```

   ---

6. **후행 클로저**

   ```swift
   names.sorted { $0 > $1 }
   ```

---


## Closure Expression Syntax

### 기본 클로저

```
{ (<#parameters#>) -> <#return type#> in
   <#statements#>
}
```

```swift
{ Parametor -> Return Type in // 클로저 head
    code // 클로저 body
}
```

- 파라미터와 리턴 값 존재 X

  ```swift
  let Hello = { () -> () in
      print("Hello Closure")
  }

  Hello() // Hello Closure
  ```

  ---

- 파라미터와 리턴 값 존재 O

  ```swift
  let Hello = { (name: String) -> String in
      print("Hello Closure + \( ame)")
  }

  Hello("haha") // Hello Closure haha
  ```

---

### Inferring Type(추론 타입)

> The sorted(by:) method is being called on an array of strings, so its argument must be a function of type `(String, String) -> Bool`

> This means that the (String, String) and Bool types don’t need to be written as part of the closure expression’s definition.

특정한 케이스를 제외하고 **Closure** 의 매개변수 유형과 반환 `Type` 을 컴파일러가 유추 가능

**괄호 및 반환 화살표를 생략이 가능**

- **일반 표현**

  ```swift
  reversedNames = names.sorted(by: { s1, s2 in return s1 > s2
  ```

  ---

- **단일 표현식**

  ```swift
  reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
  ```

  ---

- **argument 생략**
  ```swift
  // Swift는 $0, $1, $2 등의 이름으로 클로저 argument 값을 참조하는 데 사용
  reversedNames = names.sorted(by: { $0 > $1 } )
  ```

---

### Trailing Closure(후행 클로저)

> 메서드의 마지막 파라미터가 **Closure** 일 때

> 이를 파라미터 값 형식이 아닌 메서드 뒤에 붙여 작성된 Closure(Argument Label은 생략 가능)

```swift
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}


// Here's how you call this function without using a trailing closure:


someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
})


// Here's how you call this function with a trailing closure instead:


someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}
```

Closure를 파라미터 처럼 사용

```swift
func HelloFunc(closure: () -> ()) {
    closure()
}

HelloFunc(closure: { () -> () in
    print("Hello Closure")
})
```

---

### 반환 타입이  Closure

```swift
func HelloFunc() -> () -> () {
    return { () -> () in
        print("Hello Closure")
    }
}

HelloFunc()() // Hello Closure
```

---

### 여러 Closure in 파라미터

> 주로 REST API 호출하거나 Combine 등에서 자주 보는 형태


```swift
func fetch(success:() -> (), fail: -> () -> ()) {
    // Code
}

fetch(success: { () -> () in
    print("성공")
}, fail: { () - > () in
    print("실패")
})
```

## 참고

[공식문서 - Closures](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/)

[블로그 참조 - 기초 문법 - 클로저에 대한 간단한 개념 (closure)(감자)](https://didu-story.tistory.com/173)

[블로그 참조 - 클로저(Closure) 정복하기(개발자 소들이)](https://babbab2.tistory.com/81)
