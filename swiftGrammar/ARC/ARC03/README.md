## Weak References

> 약한 참조는 참조하는 인스턴스를 강력하게 유지하지 않는 참조
> <br/>
> ARC가 참조된 인스턴스를 폐기하는 것을 막지 않게 하는 것
> <br/>
> 참조가 강력한 참조 순환의 일부가 되는 것을 방지
> <br/>
> 속성 또는 변수 선언 앞에 약한 키워드를 배치하여 약한 참조를 표현
> <br/>

즉 약한 참조의 특징
<br/>

- **인스턴스를 참조할 시, RC를 증가 X**
  <br/>

- **참조하던 인스턴스가 메모리에서 해제된 경우, 자동으로 nil이 할당되어 메모리가 해제**
  <br/>

- **weak는 무조건 옵셔널 타입의 변수**
  <br/>

약한 참조는 자신이 참조하는 인스턴스를 강력하게 유지하지 않기 때문에 약한 참조가 여전히 참조하는 동안 해당 인스턴스가 할당 해제가 가능
<br/>
따라서 ARC는 참조하는 인스턴스가 할당 해제될 때 자동으로 약한 참조를 nil로 설정
<br/>
약한 참조는 런타임 시 값이 nil로 변경될 수 있도록 허용해야 하므로 항상 선택적 유형의 상수가 아닌 변수로 선언되는 것
<br/>

> Property observers는 ARC가 약한 참조를 nil로 설정할 때 호출 X
> <br/> > <br/>

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

    weak var tenant: Person?

    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

// 두 변수 또한 선택 사항이기 때문에 초기 값이 nil -> 옵셔널로 정의
var john: Person?
var unit4A: Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john
```

<br/>

두 변수(john 및 unit4A)의 강력한 참조와 두 인스턴스 간의 링크는 이전과 같이 생성이 될 것
<br/>

![img](https://docs.swift.org/swift-book/images/weakReference01@2x.png)
<br/>

Person 인스턴스에는 여전히 Apartment 인스턴스에 대한 강한 참조가 있지만 Apartment 인스턴스에는 이제 Person 인스턴스에 대한 약한 참조가 존재
<br/>

즉, **john 변수를 nil로 설정하여 강한 참조를 해제하면 Person 인스턴스에 대한 강한 참조가 더 이상 존재 X**
<br/>

```swift
john = nil // "John Appleseed is being deinitialized"
```

<br/>

Person 인스턴스에 대한 강력한 참조가 더 이상 없기 때문에 할당이 취소되고 테넌트 속성이 nil로 설정이 되는 것
<br/>

![img](https://docs.swift.org/swift-book/images/weakReference02@2x.png)
<br/>

Apartment 인스턴스에 대한 강력한 참조도 동일하게 설정 될 것
<br/>

```swift
unit4A = nil // "Apartment 4A is being deinitialized"
```

<br/>

![img](https://docs.swift.org/swift-book/images/weakReference03@2x.png)
<br/>

## 참고

https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/#Weak-References
<br/>
