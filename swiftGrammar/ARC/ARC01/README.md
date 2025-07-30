# ARC(Automatic Reference Counting)

> *Swift* 는 **ARC(Automatic Reference Counting)** 를 사용하여 앱의 메모리 사용량을 추적하고 관리

> *ARC* 는 해당 인스턴스가 더 이상 필요하지 않을 때 클래스 인스턴스에서 사용하는 메모리를 자동으로 해제

- *Swift(UIKit 환경)* 에선 주로 메모리 구조 중 **힙(Heap)** 을 주로 다루게 됨

- **ARC** 가 메모리 영역 중 힙 영역을 관리하게 됌

---

## Intro

- `struct`, `enum` 은 Value 타입 : **스택(Stack)** 에 저장

- `class` 는 Reference 타입 : **힙(Heap)** 에 저장, 참조 카운트 기반 메모리 관리 필요

    ```swift
    var a: Person? = Person()
    var b = a  // 참조 카운트 +1
    a = nil    // 참조 카운트 -1 (b가 여전히 참조 중)
    b = nil    // 참조 카운트 -> → ARC가 메모리 해제
    ```

---

## ARC를 사용해야하는 이유

> **ARC** 는 **"자동"** 이지만 완전한 **"알아서 다 해주는 것"** 은 아님

- *Swift* 는 자동으로 메모리를 관리하지만,

- 참조 사이클을 개발자가 설계 단계에서 조심하지 않으면 **메모리 누수** 가 발생함

   ```swift
   // 서로 Strong(추후에 나옴)
   class A {
      var b: B?
   }

   class B {
      weak var a: A?
   }
   ```

- 그렇기 때문에 ARC를 다룰 줄 알아야함

---

## GC vs RC

> *Swift* 의 **ARC** 가 **RC(Reference Counting)** 기반으로 동작하며,

> **GC(Garbage Collection)** 와 다르게 컴파일 타임에 **retain**/**release** 를 관리하므로

> 예측 가능하고 효율적이지만, 순환 참조 문제는 개발자가 해결해야 함

> 힙 영역의 메모리를 관리하는 방법은 GC와 RC가 존재

- *GC (Garbage Collection)* : **java** 처럼 런타임에 주기적으로 메모리를 검사해서 더 이상 참조되지 않는 객체를 제거

- *RC (Reference Counting)* : 객체가 참조될 때 카운트를 증가시키고, 참조가 해제될 때 감소 -> `0` 이 되면 메모리 해제

**Swift는 GC가 아닌 RC 기반, 정확히는 ARC를 사용**

---

## retain / release

**ARC** 은 런타임이 아닌 컴파일 타임에 **Reference Counting** 관리 코드를 삽입

```swift
var a = Person()  // ARC가 retain 삽입
a = nil           // ARC가 release 삽입
```

---

## Automatic Reference Counting(자동 참조 카운트) 과 Heap

```swift
class Person {
    let name: String

    init(name: String) { // 1
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

// 2
var reference1: Person?

// 3
reference1 = Person(name: "John Appleseed") // John Appleseed is being initialized

// 4
let cloneRef = reference1
```

1. `Person` 클래스의 이니셜라이저를 호출하는 지점에 `"John Appleseed is being initialized"` 라는 메시지가 출력

   ```swift
   init(name: String) {
       self.name = name
       print("\(name) is being initialized")
   }
   ```

   ---

2. `Optional` 이므로 자동으로 `nil` 값으로 초기화, 현재 `Person` 인스턴스를 참조를 하지 않음

    ```swift
    // referencel 는 스택영역에 할당
    var reference1: Person?
    ```

    ---

3. 새로운 `Person` 인스턴스가 `reference1` 변수에 할당

   ```swift
   // Person(name: "John Appleseed")은 힙영역에 할당
   reference1 = Person(name: "John Appleseed")
   ```

   - `reference1` 에서 새 `Person` 인스턴스에 `Strong` 참조가 생김

   - 적어도 하나의 `Strong` 참조가 있기 때문에 **ARC** 는 `Person` 이 메모리에 유지되고 할당이 취소되지 않게 되는 것

   ---

4. 인스턴스가 복사되는 것이 아닌 같은 힙 영역을 가르킴

    ```swift
    let cloneRef = reference1
    ```
    
    - 적어도 하나의 **`Strong` 참조**가 있기 때문에
    
    - 즉 `reference1` , `cloneRef` 이 같은 **메모리를 참조**

---

## Strong Reference(강한 참조)

> 강한 참조(Strong Reference)는 객체의 소유권을 나타내는 기본 참조 방식

1. **기본 참조 방식:**

    Swift에서 클래스 인스턴스에 대한 기본 참조 방식은 강한 참조

2. **Reference Counting 증가:**

    강한 참조는 객체를 참조할 때마다 해당 객체의 참조 카운트를 1씩 증가

3. **메모리 해제 방지:**

    **Reference Counting(참조 카운트)** 가 `0`이 될 때까지 객체는 메모리에서 해제되지 않음

4. **순환 참조 문제:**

    여러 객체가 서로 **Strong Reference(강한 참조)** 를 하는 경우, 순환 참조가 발생하여 **메모리 누수(memory leak)** 가 발생할 수 있음

    ```swift
    reference1 = nil
    reference2 = nil
    ```

    - 두 개의 변수에 nil을 할당하여 이러한 두 개의 **강한 참조(원래 참조 포함)**를 중단하면
    
    - 하나의 강한 참조가 유지되고  `Person 인스턴스` 가 할당 해제되지 않음

    ```swift
    reference3 = nil // "John Appleseed is being deinitialized"
    ```

    - **ARC** 는 세 번째이자 마지막 **강한 참조**가 끊어질 때까지 `Person` 인스턴스를 할당 해제되지 않음

    - [강한 참조 순환](https://github.com/BOLTB0X/Swift_Study/tree/main/swiftGrammar/ARC/ARC02)
---

## 참고

- [공식문서 - ARC-in-Action](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/)

- [블로그 참조 - 메모리 관리 (1/3) - ARC(Automatic Reference Counting)(개발자 소들이)](https://babbab2.tistory.com/26)

- [블로그 참조 - ARC와 강한 참조 사이클(Strong Reference Cycle)(PinguiOS:티스토리)](https://icksw.tistory.com/204)

- [블로그 참조 - 클로저를 사용할 때 주의할 점 - Memory Leaks, Retain Cycle, nested closure 첫 번째(김종권의 iOS 앱 개발 알아가기)](https://ios-development.tistory.com/1233)

