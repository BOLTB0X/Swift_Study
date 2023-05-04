# Closures capture

> A closure can capture constants and variables from the surrounding context in which it’s defined.
> <br/>
> 클로저가 매개변수나 지역변수가 아닌 주변 외부의 context를 사용하기 위해 주변 외부의 context를 참조하는 것(Capturing by reference)
> <br/>

클로저는 자신이 정의된 스코프 외부의 값을 참조할 수 있음
<br/>

클로저가 자신이 참조하는 외부 변수나 상수를 캡처해서 내부에서 사용할 수 있도록 하는 것 -> **_참조된 값들은 클로저 내부에서 캡쳐된거라 표현_**
<br/>

## Capturing Values

공식문서 코드로 예를 들자면
<br/>

```swift
// Int 타입을 매개변수로 갖고, () -> Int 의 타입인 클로저를 반환 하는 함수
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int { // incrementer라는 함수가 클로저의 역활로 반환
        runningTotal += amount
        return runningTotal // runningTotal과 amount을 캡쳐해서 사용
    }
    return incrementer
}
```

<br/>

1. makeIncrementer 호출
   <br/>

2. makeIncremeter의 매개변수인 amount와 지역변수인 runningTotal을 incrementer라는 클로저에서 캡쳐해서 사용
   <br/>

```swift
func incrementer() -> Int {
    runningTotal += amount
    return runningTotal
}
```

<br/>

> incrementer 함수에는 매개 변수가 없지만 함수 본문 내에서 runningTotal 및 amount를 참조
> <br/>
> 이는 surround 함수로부터 amount와 runningTotal에 대한 참조를 캡처(Cpaturing by reference)하여 자체 함수 body 내에서 사용하여 수행
> <br/> > **_참조로 캡처(Capturing by reference)하면 makeIncrementer에 대한 호출이 종료 될 때_** > <br/> > **_runningTotal과 amount가 사라지지 않으며 다음에 incrementer 함수가 호출 될 때 runningTotal을 사용할 수 있는 것_** > <br/>
> <br/>

아래의 코드로 실행해보면
<br/>

```swift
let incrementByTen = makeIncrementer(forIncrement: 10) // incrementByTen은 makeIncrementer 라는 함수를 호출해서 반환된 클로저

print(incrementByTen()) // returns a value of 10
print(incrementByTen()) // returns a value of 20
print(incrementByTen()) // returns a value of 30

let incrementBySeven = makeIncrementer(forIncrement: 7)
print(incrementBySeven()) // returns a value of 7

print(incrementByTen()) // returns a value of 40

```

<br/>

> makeIncrementer()을 호출했으므로 그 안에 있는 지역변수인 runningTotal이나 매개변수인 amount는 함수가 종료되면 사라지는게 정상이지만
> <br/>
> incrementByTen이 이 둘을 캡쳐함으로써 계속 살아있게 되고, 따라서 이 클로저를 호출함에 따라 값이 updating이 됨을 알 수 있음
> <br/>
> 클로저는 또 reference 타입이라 클로저의 reference count가 0이 되지 않는 한 캡쳐한 runningTotal이나 amount는 사라지지 X
> <br/>

## capturing by reference

> Closure는 값을 캡쳐할 때 Value/Reference 타입에 관계 없이 Reference Capture
> <br/>

변수를 클로저 내부적으로 저장하는 형식, 일반적으로 변수 타입에 따라 value type이면 값을 복사해 저장하지만
<br/>

클로저는 Value/Reference 타입에 관계없이 캡쳐하는 값들을 참조하고 이 를 **_Reference Capture_**라고 함
<br/>

```swift
// 클로저 외부에서 변경하는 경우
func somethingInFunc() {
    var n = 0
    print("1: \(n)")

    let closure = { // 외부 변수 n을 클로저 내부에서 캡처함
        print("3: \(n)") // 이를 Reference Capture

    }

    n = 10
    print("2: \(n)")
    closure()
}

somethingInFunc()
// 1: 0
// 2: 10
// 3: 10
```

<br/>

즉 결과로 알 수 있듯히 **_n이란 변수를 참조하는 것_**
<br/>

**_closure를 실행하기 전에 변수 n을 외부에서 변경하면 클로저 내부에서 사용되는 변수 n은 변경 되어지는 것_**
<br/>

```swift
// 클로저 내부에서 변경하는 경우
func somethingOutFunc() {
    var n = 0
    print("1: \(n)")

    let closure = { // 외부 변수 n을 클로저 내부에서 캡처함
        n = 20 // 내부에서 변경
        print("3: \(n)") // 이를 Reference Capture

    }

    closure()
    print("2: \(n)")
}

somethingOutFunc()
// 1: 0
// 2: 20
// 3: 20
```

<br/>

내부에서도 변경이 됌
<br/>

closure란 익명함수는 클로저 내부에서 외부 변수인 str2이라는 변수를 사용하여 print
<br/>

str2의 값을 클로저 내부적으로 저장하고 있는 이런 걸 **_str2의 값이 캡쳐되었다라고 함_**
<br/>

str1은 캡쳐되어있지 X
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

즉 **_escaping closure는 함수가 반환된 이후에도 실행될 수 있는 closure_**
<br/>
보통 함수의 파라미터로 closure를 받을 때, 함수의 실행이 완료된 이후에는 해당 closure가 더이상 실행되지 않도록 default로 non-escaping closure가 사용
<br/>

```swift
func someThingFunc(closure: @escaping() -> ()) {
    let constant : () -> () = closure
}

func sampleFunction(closure: @escaping() -> ()) {
    print("함수 시작")

    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {// Escaping closure captures non-escaping parameter
        closure()
    }

    print("함수 종료")
}

func outFunc(closure: @escaping() -> ()) -> () -> () {
    func localFunc() {
        closure()
    }

    return inFunc() // Escaping local function cpatures non-escaping parameter 'closure'
}
```

<br/>

---

## 참고

https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/#Autoclosures
<br/>
https://babbab2.tistory.com/83
<br/>
https://developer.apple.com/documentation/swift/assert(_:_:file:line:)
<br/>
