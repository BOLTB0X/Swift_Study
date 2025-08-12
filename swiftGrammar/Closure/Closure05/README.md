# Closure의 Capture List

> 클로저가 자신이 참조하는 외부 변수나 상수를 캡쳐(Capture)하는 방법을 지정하는 방법

- **_Value Capture(복사해서 사용하는 방법)_**
- **_Reference Capture(참조를 유지하는 방법)_**

**Value Capture** 할 때 사용하는 문법 -> **Caputure List**

---

## Capture List

> Caputure List는 클로저 헤더와 중괄호 사이에 대괄호(`[]`)를 표시하며 대괄호 안에는 캡처할 값의 이름을 명시

캡처된 값을 값을 복사해서 사용하는 것을 **Value Capture(복사해서 사용하는 방법)**

```swift
// 예시
let closure = { [a, b, c] in
    // code
}
```
- Caputure List에서 쓴 arguments들이 참조타입이 아니라면 해당 요소들은 클로저가 생성될때 초기화

```swift
var a = 0
var b = 0

let closure = { [a] in
	print(a,b) // 1
    b = 20 // 2
}

a = 10
b = 10
closure() // 0 10
print(b) // 20
// 3
```

1. `a` 는 Caputure List, 클로저가 생성될때 값 `0`을 획득

2. `b` 는 Caputrue List X

3. `a` , `b` 의 값을 `10` 으로 변경한 후 클로저를 실행하면 `a` 는 클로저가 생성되었을때 캡쳐한 값 `0` 을 갖음

    - 하지만 `b` 는 변경된 값을 사용

> `a` 는 클로저가 생성됨과 동시에 Caputure List 내에 다시 a라는 이름의 상수로 초기화한 것

클로저를 실행하기 전, 외부 변수를 변경하며 값을 복사해서 쓸라면? -> **Value Capture**

---

## Value Capture

```swift
func func() {
    var num: Int = 0
    print("num 확인 #1 = \(num)")

    let closure = { [num] in
        print("num 확인 #3 = \(num)")
    }

    num = 20
    print("num 확인 #2 = \(num)")
    closure()
}

func()
//num 확인 #1 = 0
//num 확인 #2 = 20
//num 확인 #3 = 0
```

- 주의할 점은 closure 내부에서 **Value Capture** 된 값을 변경할 수 없음

---


## Reference Capture 방식

> Capture List에 강한 캡쳐(Strong Capture) , 약한 캡쳐(Weak Capture) , 비소유 캡쳐(Unowned Capture) 를 참조할 것인지 정해줄 수 있음

- 즉 클로저가 외부 변수를 참조할 때, 해당 변수의 수명과 관련된 문제를 생각해야함

- 이를 위해 클로저 캡처 **capture list** 를 사용하여 변수의 참조 방식을 지정하는 것

---

### Strong Capture(강한 캡쳐)

> 클로저가 외부 변수를 참조할 때, 해당 변수의 참조 횟수를 증가시킴

```swift
class MyClass {
    var value = 0

    func doSomething() {
        let closure = {
            print(self.value)
        }

        closure() // 1
    }
}

let obj = MyClass()
obj.doSomething() // 0
```

1. 클로저가 강한 참조로 `self` 를 캡처하므로 `self` 의 인스턴스를 사용할 수 있음

---

### Weak Capture(약한 캡쳐)

> 클로저가 외부 변수를 약하게 참조하며, 변수의 참조 횟수를 증가시키지 않음

```swift
class weekClass {
    var value = 10

    func doSomething() {
        // 약한 참조로 self를 캡처하는 클로저
        let closure = { [weak self] in
            if let self = self {
                print(self.value)
            } else {
                print("객체가 이미 해제됨")
            }
        }

        closure() // 1
    }
}

let obj = weekClass()
obj.doSomething() // 10
```

1. `weak` 참조로 `self` 를 캡처하므로 `self` 의 인스턴스가 해제되어도 클로저가 실행됨

    - 이는 클로저가 약한 참조로 `self` 를 가지고 있기 때문에
    
    - `self` 의 **참조 횟수가 증가되지 않으며 클로저가 실행되는 동안에만 해당 인스턴스가 유지되는 것**

---

### Unowned Capture(비소유 캡쳐)

> 클로저가 외부 변수를 참조하지만, 변수의 수명이 클로저와 같거나 더 길다고 가정하는 것, 따라서 변수의 참조 횟수를 증가시키지 않고, 클로저가 해제될 때 변수도 함께 해제됌

```swift
class UnownedClass {
    var value = 0

    func doSomething() {
        // 비소유 참조로 self를 캡처하는 클로저
        let closure = { [unowned self] in
            print(self.value)
        }

        closure() // 1
    }
}

let uObj = UnownedClass()
uObj.doSomething() // 0
```

1. 클로저가 미소유 참조로 `self` 를 캡처하므로 `self` 의 인스턴스가 해제되면 런타임 에러가 발생함

   - `uObj`의 참조 카운트가 `0` 이 되는 시점에 메모리에서 해제될 경우

2. 이때 발생하는 런타임 에러 -> "Use of unowned reference after instance is deallocated"

---

## Reference Count(참조 횟수) 관리

1. **Strong Capture(강한 캡쳐)**

   - 외부 변수의 참조 횟수를 증가시키므로, 클로저가 사용 중인 동안 변수가 메모리에 유지


2. **Weak Capture(약한 캡쳐)과 Unowned Capture(비소유 캡쳐)**

   - 외부 변수의 참조 횟수를 증가시키지 않으므로, 클로저가 사용 중이더라도 변수가 해제될 수 있음
   

   - 이런 경우, 외부 변수가 이미 메모리에서 해제된 상태일 수 있으므로, 변수를 옵셔널로 선언하여 클로저가 변수를 사용할 때 `nil` 여부를 체크해야 함


   ```swift
   var wObj: WeekClass? = WeekClass()
   wObj!.doSomething() // 10

   var uObj: UnownedClass? = UnownedClass()
   uObj!.doSomething() // 0

   // 객체 해제
   wObj = nil
   uObj = nil
   // WeakClass 객체가 해제됨
   // UnownedClass 객체가 해제됨
   ```

---

## Weak Capture(약한 캡쳐)과 Unowned Capture(비소유 캡쳐) 주의할 점

```swift
class WeekClass {
    var value: Int

    // 생략
    // ...
    lazy var doSay: () -> String = { [weak self] in
        "\(self) !!!"
    }

    // 생략
    // ...
}

class UnownedClass {
    var value: Int

    // 생략
    // ...
    lazy var doSay: () -> String = { [unowned self] in
        "\(self) !!!"
    }

    // 생략
    // ...
```

```swift
uObj?.doSay = wObj?.doSay ?? { "~~~" } // uObj의 value를 wObj의 프로퍼티로 참조 할당

// 객체 해제
uObj = nil

print(uObj?.doSay)
print(wObj?.doSay) // 에러 발생
```

<img width="243" alt="메모리릭" src="https://github.com/BOLTB0X/Swift_Study/assets/83914919/d038984f-e3c4-40fe-a106-6c91c860d29f">

```
Optional((Function))
Playground execution failed:

error: Execution was interrupted, reason: EXC_BAD_ACCESS (code=EXC_I386_GPFLT).
The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation.

* thread #1, queue = 'com.apple.main-thread', stop reason = EXC_BAD_ACCESS (code=EXC_I386_GPFLT)
  * frame #0: 0x00007ff800311463 CoreFoundation`-[NSTaggedPointerString hash] + 81
    frame #1: 0x00007ff80049c273 CoreFoundation`-[__NSDictionaryM objectForKey:] + 104
    frame #2: 0x00007ff800c3c1ae Foundation`-[NSProcessInfo environment] + 603
    frame #3: 0x000000010d5c75a6 MyPlayground`main + 70
```

- `uObj` 를 해제한 후에도 `wObj` 의 참조는 여전히 남아 있는 경우

- 이는 `uObj` 의 `doSay` 프로퍼티가 `wObj` 의 `doSay` 클로저를 참조하고 있기 때문에 발생하는 문제

- 이로 인해 `wObj` 가 해제되지 않고 메모리에 유지되며, 메모리릭가 발생

> 만약 비소유 참조로 문제가 발생 시 약한 참조로 변경하고 옵셔널을 사용해도 무방

---

## 참고

[공식문서 - Capturing Values](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/#Capturing-Values)

[블로그 참고 - 획득목록(Capture list), 캡쳐리스트 란? -HoonIOS](https://boidevelop.tistory.com/37)
