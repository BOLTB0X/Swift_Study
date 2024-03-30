# Closures capture

> A closure can capture constants and variables from the surrounding context in which it’s defined.

클로저가 매개변수나 지역변수가 아닌 주변 외부의 context를 사용하기 위해 주변 외부의 context를 참조하는 것 (Capturing by reference)

클로저는 자신이 정의된 스코프 외부의 값을 참조할 수 있음

클로저가 자신이 참조하는 외부 변수나 상수를 캡처해서 내부에서 사용할 수 있도록 하는 것 -> **_참조된 값들은 클로저 내부에서 캡쳐된거라 표현_**

## Capturing Values

> makeIncrementer 호출
> makeIncremeter의 매개변수인 amount와 로컬변수인 runningTotal을 incrementer라는 클로저에서 캡쳐해서 사용

```swift
// 1
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0

    func incrementer() -> Int { // 2
        runningTotal += amount
        return runningTotal // 3
    }

    return incrementer
}

// 4
func incrementer() -> Int {
    runningTotal += amount
    return runningTotal
}
```

1. Int 타입을 매개변수로 갖고, () -> Int 의 타입인 클로저를 반환 하는 함수
   <br/>

2. incrementer라는 함수가 클로저의 역활로 반환
   <br/>

3. runningTotal과 amount을 캡쳐해서 사용
   <br/>

4. incrementer 함수에는 매개 변수가 없지만 함수 본문 내에서 runningTotal 및 amount를 참조, 이는 surround 함수로부터 amount와 runningTotal에 대한 참조를 캡처(Cpaturing by reference)

**_참조로 캡처(Capturing by reference)하면 makeIncrementer에 대한 호출이 종료 될 때_**

**_runningTotal과 amount가 사라지지 않으며 다음에 incrementer 함수가 호출 될 때 runningTotal을 사용할 수 있는 것_**

아래의 코드로 실행해보면

```swift
let incrementByTen = makeIncrementer(forIncrement: 10) // incrementByTen은 makeIncrementer 라는 함수를 호출해서 반환된 클로저

print(incrementByTen()) // 10
print(incrementByTen()) // 20
print(incrementByTen()) // 30

let incrementBySeven = makeIncrementer(forIncrement: 7)
print(incrementBySeven()) // 7

print(incrementByTen()) // 40
```

makeIncrementer()을 호출했으므로 그 안에 있는 지역변수인 runningTotal이나 매개변수인 amount는 함수가 종료되면 사라지는게 정상이지만

incrementByTen이 이 둘을 캡쳐함으로써 계속 살아있게 되고

따라서 이 클로저를 호출함에 따라 값이 updating이 됨을 알 수 있음

클로저는 또 reference 타입이라 클로저의 reference count가 0이 되지 않는 한 캡쳐한 runningTotal이나 amount는 사라지지 X

## capturing by reference

> Closure는 값을 캡쳐할 때 Value/Reference 타입에 관계 없이 Reference Capture

변수를 클로저 내부적으로 저장하는 형식, 일반적으로 변수 타입에 따라 value type이면 값을 복사해 저장하지만

클로저는 Value/Reference 타입에 관계없이 캡쳐하는 값들을 참조하고 이 를 **Reference Capture**라고 함

1. **Closure 외부에서 변경**하는 경우

   ```swift
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

   즉 결과로 알 수 있듯, n이란 변수를 참조하는 것

   > closure를 실행하기 전에 변수 n을 외부에서 변경하면
   > 클로저 내부에서 사용되는 변수 n은 변경 되어지는 것

   <br/>

2. **클로저 내부에서 변경**하는 경우

   ```swift
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

   내부에서도 변경이 됌

   <br/>

3. 캡쳐되었다는 표현

   ```swift
   var str2 = "Hello"

   let closure = {
       print(str2)
   }

   str2 = "World"

   closure() // "World"
   ```

   외부 변수의 값을 저장하고 있는 것을 **캡쳐**

## 참고

[공식문서 - Capturing Values](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/#Capturing-Values)
