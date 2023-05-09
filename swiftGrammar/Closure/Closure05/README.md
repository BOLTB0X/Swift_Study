# Closure의 Capture List

> 클로저가 자신이 참조하는 외부 변수나 상수를 캡쳐(Capture)하는 방법을 지정하는 방법
> <br/>

캡처된 값을 클로저 내에서 사용할 수 있도록 해주는데, Swift에서는 **_Value Capture(복사해서 사용하는 방법)_**과 **_Reference Capture(참조를 유지하는 방법)_** 두 가지가 존재
<br/>

Value Capture할 때 사용하는 문법이 Caputure List
<br/>

Caputure List는 클로저 헤더와 중괄호 사이에 대괄호([])를 표시하며 대괄호 안에는 캡처할 값의 이름을 명시
<br/>

캡처된 값을 값을 복사해서 사용하는 것을 Value Capture(복사해서 사용하는 방법)
<br/>

```swift
let closure = { [a, b, c] in
    // code
}
```

<br/>

## Value Capture

클로저를 실행하기 전, 외부 변수를 변경하며 값을 복사해서 쓸라면? -> **Value Capture**
<br/>

```swift
func doFunc() {
    var num: Int = 0
    print("num 확인 #1 = \(num)")

    let closure = { [num] in
        print("num 확인 #3 = \(num)")
    }

    num = 20
    print("num 확인 #2 = \(num)")
    closure()
}

doFunc()
//num 확인 #1 = 0
//num 확인 #2 = 20
//num 확인 #3 = 0
```

<br/>

주의할 점은 closure 내부에서 Value Capture된 값을 변경할 수 없음
<br/>
