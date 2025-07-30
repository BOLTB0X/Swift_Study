# Strong Reference Cycles Between Class Instances

> **ARC** 는 생성한 새 인스턴스에 대한 참조 수를 추적하고 해당 `Person` 인스턴스가 더 이상 필요하지 않을 때 할당을 해제할 수 있음

> 클래스의 인스턴스가 **강한 참조(Strong Reference)** 가 해제가 되지 않는 코드를 작성되는 경우가 존재

- 이는 두 클래스 인스턴스가 서로에 대한 강력한 참조를 유지하여 각 인스턴스가 서로를 활성 상태로 유지하는 경우에 발생 가능

- 이를 **Strong Reference Cycles(강한 참조 순환)**

## Intro

```swift
class Person {
    let name: String
    init(name: String) {
        self.name = name
    }

    var apartment: Apartment?
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    let unit: String
    init(unit: String) {
        self.unit = unit
    }

    var tenant: Person?
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }

    var john: Person?
    var unit4A: Apartment?
}
```

*두 클래스는 모두 해당 클래스의 인스턴스가 초기화 해제되고 있다는 상황을 print로 나타내기 위해 `init`, `deinit` 정의*

## Strong Reference Cycles

```swift
john = Person(name: "John Appleseed") // 1
unit4A = Apartment(unit: "4A") // 2
```

<p align="center">
   <img src="https://docs.swift.org/swift-book/images/org.swift.tspl/referenceCycle01@2x.png" alt="Example Image" width="80%">
</p>

<br/>

1. `john` 은 이제 새로운 `Person` 인스턴스에 대한 **강한 참조** 를 가짐

2. `unit4A` 는 새로운 `Apartment` 인스턴스에 대한 **강한 참조** 를 가짐

---

```swift
john!.apartment = unit4A // 3
unit4A!.tenant = john // 4
```

3. `john`이  `apartment`를 갖고

4. `unit4A`가 `tenant`를 갖도록 연결

---

<p align="center">
   <img src="https://docs.swift.org/swift-book/images/org.swift.tspl/referenceCycle02@2x.png" alt="Example Image" width="80%">
</p>


5. 두 인스턴스를 연결하면 그들 사이에 강력한 **참조 순환**이 생성

6. `Person` 인스턴스에는 `Apartment` 인스턴스에 대한 **강력한 참조**가 있고

7. `Apartment` 인스턴스에는 `Person` 인스턴스에 대한 **강력한 참조** 가 생겨 버림

    - `john` 및 `unit4A` 가 **강력한 참조** 를 중단해도 **RC(참조 횟수)** 가 `0`으로 떨어지지 않음
    
    - 인스턴스가 ARC에 의해 할당 해제가 되지 못함

---

```swift
john = nil
unit4A = nil
```

<p align="center">
   <img src="https://docs.swift.org/swift-book/images/org.swift.tspl/referenceCycle03@2x.png" alt="Example Image" width="80%">
</p>


- 두 변수를 `nil`로 설정하면, `deinit( **deinitializer** )`가 호출되지 않음

- **강한 참조 순환** 은 `Person` 및 `Apartment` 인스턴스가 할당 해제가 되도

- `Person` 및 `Apartment` 내 프로퍼티들은 **강한 참조** 는 해제되지 못해 앱에서 메모리 누수가 발생

- 이를 해결할 방법은 바로 [weak references](https://github.com/BOLTB0X/Swift_Study/tree/main/swiftGrammar/ARC/ARC03)와 [unowned references](https://github.com/BOLTB0X/Swift_Study/tree/main/swiftGrammar/ARC/ARC04)

## 참고

[공식문서 - Strong Reference Cycles Between Class Instances](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/)

[블로그 참조 - 개발자 소들이](https://babbab2.tistory.com/27)
