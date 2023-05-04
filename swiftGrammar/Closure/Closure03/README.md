# @Escaping Closures

> A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns.
> <br/>
> 클로저는 함수에 대한 인수로 전달되지만 함수가 반환된 후에 호출될 때 함수를 이스케이프
> <br/>

클로저를 사용할 때 함수나 메서드 매개변수의 타입 앞에 붙여서 사용하는 키워드
<br/>

**_함수 실행을 벗어나서 함수가 끝난 후에도 클로저를 실행하거나,_**
<br/>

**_중첩함수에서 실행 후 중첩 함수를 리턴하고 싶거나, 변수 상수에 대입하고 싶은 경우에 이용_**
<br/>

```swift
// 예시
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
```

<br/>

## non-escaping Closure

여태 closure를 사용했던 것은 **_non-escaping_**
<br/>

기존에 클로저를 사용했던 것은
<br/>

함수나 메소드의 실행이 끝난 후에도 계속해서 사용되지 않는 경우에 사용, 함수의 실행이 완료되면, 해당 클로저가 함수의 스코프 밖으로 벗어나게 됩
<br/>

해당 함수가 실행되는 동안에만 호출되며, 함수의 실행이 완료되면 메모리에서 해제
<br/>

일반적으로, Swift에서는 기본적으로 non-escaping closure로 설정되어 있음
<br/>

그러나 클로저를 다른 함수나 메소드로 전달하여 그 함수나 메소드 내에서 호출하는 경우, 클로저가 실행되는 동안에는 해당 함수나 메소드의 실행이 끝난 후에도 계속 사용되어야 하는 경우가 있는데
<br/>

@escaping 키워드를 사용하여 해당 클로저가 실행되는 동안에는 메모리에서 해제되지 않고 계속 유지될 수 있도록 해주어야 함
<br/>

---

## @Escaping을 써야하는 경우

1. 상수에 클로저를 대입하는 경우
   <br/>

```swift
func someThingFunc(closure: () -> ()) {
    let constant : () -> () = closure // non-escaping parameter 에러
}
```

<br/>

> Using non-escaping parameter 'closure' in context expecting an @escaping closure
> <br/>

함수 내부에서 직접 실행하기 위해서만 사용했는데 파라미터로 받은 클로저를 변수나 상수에 대입 X
<br/>

2. 함수 실행 흐름에서 탈출하지 않은 경우
   <br/>

```swift
func sampleFunction(closure: () -> ()) {
    print("함수 시작")

    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {// Escaping closure captures non-escaping parameter
        closure()
    }

    print("함수 종료")
}
```

<br/>

함수가 끝나고 클로저가 실행되기 때문에 에러
<br/>

**_함수가 종료되고 나서 클로저가 실행될 수 X_**
<br/>

3. 중첩함수 내부에 파라미타로 받은 클로저를 사용할 경우
   <br/>

```swift
func outFunc(closure: () -> ()) -> () -> () {
    func localFunc() {
        closure()
    }

    return inFunc() // Escaping local function cpatures non-escaping parameter 'closure'
}
```

<br/>

중첩합수를 리턴 X
<br/>

---

## 참고

https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/#Autoclosures
<br/>
https://babbab2.tistory.com/82?category=828998
<br/>
https://developer.apple.com/documentation/swift/assert(_:_:file:line:)
<br/>
