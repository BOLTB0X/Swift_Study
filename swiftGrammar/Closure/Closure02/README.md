# @autoclosure

> An autoclosure is a closure that’s automatically created to wrap an expression that’s being passed as an argument to a function.
> <br/>

**_함수에 인수로 전달되는 표현식을 래핑하기 위해 자동으로 생성되는 클로저_**
<br/>

autoclosure 를 전달받고 싶으면, 파라미터 타입을 @autoclosure attribute 로 marking 하면 됌
<br/>

autoclosure는 argument 를 가지지 않으며 리턴값이 존재해야함
<br/>

구문상의 편리함을 통해 명시적 클로저 대신 일반 표현식을 작성하여 함수 매개변수 주위의 중괄호 '(' ')'를 생략 가능
<br/>

auto 클로저는 클로저를 호출할 때까지 내부 코드가 실행되지 않기 때문에 평가? 살행?을 지연시킬 수 있음
<br/>

> 대표적으로 [assert(condition:message:file:line:)](<https://developer.apple.com/documentation/swift/assert(_:_:file:line:)>) 함수가 예
> <br/>

```swift
func assert(
    _ condition: @autoclosure () -> Bool,
    _ message: @autoclosure () -> String = String(),
    file: StaticString = #file,
    line: UInt = #line
)
```

<br/>

위에서 파라미터로 전달된 일반 구문 & 함수를 클로저로 래핑(Wrapping) 하는 것이 **_@autoclosure_**이라 했음
<br/>

**_즉 함수의 파라미터의 클로저는 실제 클로저로 전달 받는 것이 아니지만 클로저 처럼 사용하는 것_**
<br/>

클로저와 차이는 실제 클로저를 전달하는 것이 아니기 때문에 파라미터로 값을 넘기는 것 처럼 ()를 통해 구문을 넘겨 주는 것
<br/>

**_@autoclosure를 사용할 경우, @autoclosure의 파라미터가 반드시 없어야 함_**
<br/>

## closure와 차이

**_closure_**는 코드 블록을 변수에 저장하고, 필요할 때 실행할 수 있는 기능이므로 파라미터와 반환값을 가질 수 있고, 함수와 유사한 방식
<br/>

**_autoclosure_**는 인자로 전달되는 표현식을 자동으로 클로저로 변환해주는 것이라 위에서 언급
<br/>

즉, 함수가 호출될 때 전달된 인자를 클로저로 자동으로 변환하여 실행하는 것이고 이렇게 하면 인자를 전달하는데 사용되는 클로저 코드를 직접 작성 X
<br/>

autoclosure는 함수의 성능을 개선하기 위해 사용된다는 것은 **_함수가 호출될 때 매개변수가 이미 계산되어 있기 때문에, 함수 내부에서 사용하기 위해 다시 계산할 필요가 없어서 성능이 향상_**
<br/>

```swift
// closure 예제
func commonClosure(_ x: Int, function: (Int) -> Int) -> Int {
    return function(x)
}

let result1 = commonClosure(5, function: { x in x * 2 })
print(result1) // 출력: 10
```

<br/>

```swift
// autoclosure 예제
func autoClosure(_ x: Int, function: @autoclosure () -> Int) -> Int {
    return function()
}

let result2 = autoClosure(5, function: 5 * 2)
print(result2) // 출력: 10
```

결과는 같지만 실행과정이 다름
<br/>

commonClosure 함수에 클로저를 전달하여 실행, @autoclosure 어노테이션을 사용하여 인자로 전달되는 표현식을 자동으로 클로저로 변환하여 실행
<br/>

-

## 참고

https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/#Autoclosures
<br/>
https://babbab2.tistory.com/81
<br/>
https://developer.apple.com/documentation/swift/assert(_:_:file:line:)
<br/>
