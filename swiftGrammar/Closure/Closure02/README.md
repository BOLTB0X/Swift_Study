# @autoclosure

> An autoclosure is a closure that’s automatically created to wrap an expression that’s being passed as an argument to a function.

```swift
// 일반적인 Closure
func funcA(_ closure: () -> Void) {
    closure()
}

funcA({ print("Hello Closure") }) // Hello Closure
```

메서드에 argument로 전달되는 표현식을 래핑하기 위해 자동으로 생성되는 클로저

```swift
func funcA(_ closure: @autoclosure () -> Void) {
    closure()
}

funcA(print("Hello Closure"))
```

@autoclosure는 클로저를 호출할 때까지 내부 코드가 실행되지 않기 때문에 평가, 실행을 지연시키기 가능

> 대표적으로 [assert(condition:message:file:line:)](<https://developer.apple.com/documentation/swift/assert(_:_:file:line:)>) 함수가 예

```swift
func assert(
    _ condition: @autoclosure () -> Bool,
    _ message: @autoclosure () -> String = String(),
    file: StaticString = #file,
    line: UInt = #line
)
```

위에서 파라미터로 전달된 일반 구문 & 함수를 클로저로 래핑(Wrapping) 하는 것이 **@autoclosure**

**_즉 함수의 파라미터의 클로저는 실제 클로저로 전달 받는 것이 아니지만 클로저 처럼 사용하는 것_**

클로저와 차이는 실제 클로저를 전달하는 것이 아니기 때문에 파라미터로 값을 넘기는 것 처럼 ()를 통해 구문을 넘겨 주는 것

**_@autoclosure를 사용할 경우, @autoclosure의 파라미터가 반드시 없어야 함_**

## Closure와 차이

- **Closure**
  코드 블록을 변수에 저장하고, 필요할 때 실행할 수 있는 기능이므로 파라미터와 반환값을 가질 수 있고, 메서드와 유사한 방식
  <br/>

- **@autoclosure**
  argument로 전달되는 표현식을 자동으로 클로저로 변환해주는 것
  <br/>

## @autoclosure 존재 이유

> @autoclosure는 함수의 성능을 개선하기 위해 사용

메서드가 호출될 때 전달된 argument를 Closure로 자동으로 변환하여 실행

이렇게 하면 argument를 전달하는데 사용되는 클로저 코드를 직접 작성 X

**메서드가 호출될 때 매개변수가 이미 계산되어 있기 때문에, 메서드 내부에서 사용하기 위해 다시 계산할 필요가 없으므로 성능이 향상**

- closure

  ```swift
  func commonClosure(_ x: Int, func: (Int) -> Int) -> Int {
      return function(x)
  }

  let result1 = commonClosure(5, func: { x in x * 2 })
  print(result1) // 10
  ```

  commonClosure 메서드에 클로저를 전달하여 실행
  <br/>

- @autoclosure

  ```swift
  func autoClosure(_ x: Int, function: @autoclosure () -> Int) -> Int {
      return function()
  }

  let result2 = autoClosure(5, function: 5 * 2)
  print(result2) // 10
  ```

  @autoclosure 어노테이션을 사용하여 argument로 전달되는 표현식을 자동으로 클로저로 변환하여 실행

## 참고

[공식문서 - Autoclosures](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/#Autoclosures)

[공식문서 - assert](<https://developer.apple.com/documentation/swift/assert(_:_:file:line:)>)

[블로그 참조](https://babbab2.tistory.com/81)
