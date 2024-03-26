## Strong Reference Cycles

> ARC는 생성한 새 인스턴스에 대한 참조 수를 추적하고 해당 Person 인스턴스가 더 이상 필요하지 않을 때 할당을 해제할 수 있음
> 클래스의 인스턴스가 강력한 참조가 없는 지점에 도달하지 않는 코드를 작성할 수 있음
> 이는 두 클래스 인스턴스가 서로에 대한 강력한 참조를 유지하여 각 인스턴스가 서로를 활성 상태로 유지하는 경우에 발생 가능
> 이를 강한 참조 순환

```swift
class Person {
    let name: String
    init(name: String) {
        self.name = name
    }

    // 아파트 프로퍼티는 선택 사항 -> 옵셔널
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

    // tenant 프로퍼티는 선택 사항 -> 옵셔널
    var tenant: Person?
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }

// 두 변수 또한 선택 사항이기 때문에 초기 값이 nil -> 옵셔널로 정의
var john: Person?
var unit4A: Apartment?
}
```

두 클래스는 모두 해당 클래스의 인스턴스가 초기화 해제되고 있다는 상황을 print로 나타내면 init, deinit를 정의

```swift
john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

// john 변수는 이제 새로운 Person 인스턴스에 대한 강한 참조를 가지며
// unit4A 변수는 새로운 Apartment 인스턴스에 대한 강한 참조를 가짐
```

![img](https://docs.swift.org/swift-book/images/referenceCycle01~dark@2x.png)

```swift
john!.apartment = unit4A
unit4A!.tenant = john
```

두 인스턴스를 함께 연결하여 개인이 아파트를 갖고 아파트가 tenant를 갖도록 연결

john 및 unit4A 선택적 변수 내에 저장된 인스턴스를 언래핑하고 액세스하는 데 사용되므로 해당 인스턴스의 속성을 설정

아래에 두 인스턴스를 함께 연결한 후의 강력한 참조를 나타낸 것

![img](https://docs.swift.org/swift-book/images/referenceCycle02@2x.png)

두 인스턴스를 연결하면 그들 사이에 강력한 **참조 순환**이 생성
<br/>

Person 인스턴스에는 Apartment 인스턴스에 대한 강력한 참조가 있고 Apartment 인스턴스에는 Person 인스턴스에 대한 강력한 참조가 생겨 버림

**_john 및 unit4A 변수가 보유한 강력한 참조를 중단해도 참조 횟수가 0으로 떨어지지 않고 인스턴스가 ARC에 의해 할당 해제 X_**

```swift
john = nil
unit4A = nil
```

주목해야하는 것은 두 변수를 nil로 설정했을 때 deinitializer가 호출되지 않았다는 점

강력한 참조 순환은 Person 및 Apartment 인스턴스가 할당 해제되어 앱에서 메모리 누수가 발생하는 것을 방지함

![img](https://docs.swift.org/swift-book/images/referenceCycle03@2x.png)

이를 해결할 방법은 바로 [weak references](https://github.com/BOLTB0X/Swift_Study/tree/main/swiftGrammar/ARC/ARC03)와 [unowned references](https://github.com/BOLTB0X/Swift_Study/tree/main/swiftGrammar/ARC/ARC04)

## 참고

[공식문서 - Strong Reference Cycles Between Class Instances](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/)

[블로그 참조](https://babbab2.tistory.com/27)
