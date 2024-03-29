# Closure (클로저)

> Group code that executes together, without creating a named function.

Closure 표현식은 간결하고 집중된 구문으로 인라인 클로저를 작성하는 방법

```swift
// 노익명함수
func Hello() {
    print("Hello Closure")
}

// 익명함수
let Hello = { print("Hello Closure") }
// 일반적인 Closure 라고 하면 Unnamed Closure
```

즉 Nested functions 을 좀 더 간결하고 유용하게 표현하는 것이 **Closure**

## Closure Expression

```
{ (<#parameters#>) -> <#return type#> in
   <#statements#>
}
```

- Expression Syntaxin page link

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

- 파라미터와 리턴 값 존재 O

  ```swift
  let Hello = { (name: String) -> String in
      print("Hello Closure + \( ame)")
  }

  Hello("haha") // Hello Closure haha
  ```

## Inferring Type(추론 타입)

> The sorted(by:) method is being called on an array of strings, so its argument must be a function of type (String, String) -> Bool.
> This means that the (String, String) and Bool types don’t need to be written as part of the closure expression’s definition.

특정 경우에는 Closure의 매개변수 유형과 반환 Type을 컴파일러가 유추할 수 있음

그러므로 괄호 및 반환 화살표를 생략이 가능

- 일반 표현

  ```swift
  reversedNames = names.sorted(by: { s1, s2 in return s1 > s2
  ```

- Single-expression closures(단일 표현식)

  ```swift
  reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
  ```

- argument
  ```swift
  // Swift는 $0, $1, $2 등의 이름으로 클로저 argument 값을 참조하는 데 사용
  reversedNames = names.sorted(by: { $0 > $1 } )
  ```

## Trailing Closure(후행 클로저)

메서드의 마지막 파라미터가 Closure일 때, 이를 파라미터 값 형식이 아닌 메서드 뒤에 붙여 작성된 Closure(Argument Label은 생략 가능)

- Closure를 파라미터 처럼 사용

  ```swift
  func HelloFunc(closure: () -> ()) {
      closure()
  }

  HelloFunc(closure: { () -> () in
      print("Hello Closure")
  })
  ```

즉 이 코드는 함수의 파라미터에 Closure를 전달 받아 함수가 호출 될 시, Closure가 실행

#### return Type -> Closure

```swift
func HelloFunc() -> () -> () {
    return { () -> () in
        print("Hello Closure")
    }
}

HelloFunc()() // Hello Closure
```

이런식 후행 클로저 사용

#### 여러 Closure in 파라미터

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

주로 REST API 호출하거나 Combine 등에서 자주 보는 형태

## 참고

[공식문서 - Closures](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/)

[블로그 참조 - 1](https://didu-story.tistory.com/173)

[블로그 참조 - 2](https://babbab2.tistory.com/81)
