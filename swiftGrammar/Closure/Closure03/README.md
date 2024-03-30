# @Escaping Closures

> A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns.

클로저는 함수에 대한 인수로 전달되지만 함수가 반환된 후에 호출될 때 함수를 벗어남

클로저를 사용할 때 함수나 메서드 매개변수의 타입 앞에 붙여서 사용하는 키워드

## 사용하는 이유

```swift
// 예시
var completionHandlers: [() -> Void] = []

func someFuncWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
```

someFuncWithEscapingClosure 메서드는 클로저를 아규먼트로 사용

이를 메서드 외부에 선언된 배열에 추가하는 코드

이 메서드의 매개변수에 @escaping을 표시하지 않으면 컴파일 타임 오류가 발생

> 비동기 작업을 하는 많은 메서드는 클로저 argument를 완료 핸들러로 사용

메서드는 작업을 시작한 후에 반환하지만 작업이 완료될 때까지 클로저가 호출되지 X

클로저는 나중에 호출하려면, 이때 @escaping 이용

- 함수 실행을 벗어나서 함수가 끝난 후에도 클로저를 실행하는 경우
  <br/>

- 중첩 함수에서 실행 후 중첩 함수를 리턴하고 싶거나, 변수 상수에 대입하고 싶은 경우

## @escaping 의 위험성

```swift
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)// 200

completionHandlers.first?()
print(instance.x) // 100
```

self가 클래스의 인스턴스를 참조하는 경우 self를 참조하는 이스케이프 클로저에 특별한 고려가 필요

이스케이프 클로저에서 self를 캡처하면 실수로 strong reference cycle(강력한 참조 순환)이 생성되기 쉬움, 자세한 것은 [ARC 참조](https://github.com/BOLTB0X/Swift_Study/tree/main/swiftGrammar/ARC)

## non-escaping Closure

> 기존에 클로저를 사용했던 것은 함수나 메소드의 실행이 끝난 후에도 계속해서 사용되지 않는 경우에 사용

여태 closure를 사용했던 것은 **_non-escaping_**

함수의 실행이 완료되면, 해당 클로저가 함수의 스코프 밖으로 벗어나게 됩 해당 함수가 실행되는 동안에만 호출되며, 함수의 실행이 완료되면 메모리에서 해제가 됌

> 일반적으로, Swift에서는 기본적으로 non-escaping closure로 설정되어 있음

그러나 클로저를 다른 함수나 메소드로 전달하여 그 함수나 메소드 내에서 호출하는 경우, 클로저가 실행되는 동안에는 해당 함수나 메소드의 실행이 끝난 후에도 계속 사용되어야 하는 경우가 있는데

@escaping 키워드를 사용하여 해당 클로저가 실행되는 동안에는 메모리에서 해제되지 않고 계속 유지될 수 있도록 해주어야 함

## @escaping을 써야하는 특정 case

1. 상수에 클로저를 대입하는 경우
   <br/>

   ```swift
   func someThingFunc(closure: () -> ()) {
       let constant : () -> () = closure // non-escaping parameter 에러
   }
   ```

   함수 내부에서 직접 실행하기 위해서만 사용했는데 파라미터로 받은 클로저를 변수나 상수에 대입 X
   <br/>

   ```swift
   func someThingFunc(closure: @escaping () -> ()) {
    let constant: () -> () = closure
   }
   ```

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

   함수가 끝나고 클로저가 실행되기 때문에 에러 -> **_함수가 종료되고 나서 클로저가 실행될 수 X_**
   <br/>

   ```swift
   func sampleFunction(closure: @escaping () -> ()) {
       print("함수 시작")

       DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
           closure()
       }
       print("함수 종료")
   }
   ```

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

   중첩합수를 리턴 X
   <br/>

   ```swift
   func outFunc(closure: @escaping () -> ()) -> () -> () {
       func localFunc() {
           closure()
       }

       return inFunc()
   }
   ```

## 참고

[공식문서 - Escaping-Closures](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/#Escaping-Closures)

[블로그 참고 1](https://babbab2.tistory.com/82?category=828998)

[블로그 참고 2](<https://developer.apple.com/documentation/swift/assert(_:_:file:line:)>)
