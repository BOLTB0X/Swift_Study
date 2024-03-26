# Unowned References(미소유 참조)

> weak reference와 마찬가지로 소유되지 않은 참조는 참조하는 인스턴스를 강력하게 유지하지 않습니다.
> 약한 참조와 달리 소유되지 않은 참조는 다른 인스턴스의 수명이 같거나 더 긴 경우에 사용
> 약한 참조와 달리 소유되지 않은 참조는 항상 값을 가질 것으로 예상 -> ~~nil로 선언 X~~

참조가 항상 할당 해제되지 않은 인스턴스를 참조한다고 확신하는 경우에만 'Unowned References(미소유 참조)'를 사용

**_강한 순환 참조가 난 경우 weak와 반대로 둘 중에 수명이 더 긴 인스턴스를 가리키는 인스턴스를 미소유 참조로 선언함_**

```swift
// 애플문서 예시 코드
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}
// 이 두 클래스는 각각 다른 클래스의 인스턴스를 속성으로 저장
//이 관계는 강력한 참조 순환을 만들 가능성이 있음
```

클래스 Customer와 클래스 CreditCard 간의 관계는 위의 약한 참조 예제에서 본 Apartment와 Person 간의 관계와 약간 다름

이 데이터 모델에서 Customer은 CreditCard가 있을 수도 있고 없을 수도 있지만 CreditCard는 항상 Customer과 연결 되어짐

CreditCard 인스턴스는 참조하는 Customer보다 오래 지속되지는 않음

이를 나타내기 위해 Customer 클래스에는 **_옵셔널 card 프로퍼티_**가 있지만 CreditCard 클래스에는 **_미소유 Customer 프로퍼티_**이 있음

또한 새 CreditCard 인스턴스는 숫자 값과 Customer 인스턴스를 사용자 정의 CreditCard 이니셜라이저에 전달해야만 생성할 수 있음

이렇게 하면 CreditCard 인스턴스가 생성될 때 CreditCard 인스턴스에 연결된 고객 인스턴스가 항상 있게 됨

CreditCard에는 항상 Customer이 있으므로 강한 참조 순환을 피하기 위해 Customer 프로퍼티을 미소유 참조(Unowned References)로 정의

```swift
// 특정 Customer에 대한 참조를 저장하는 데 사용되는 john이라는 옵셔널 고객 변수를 정의
// 이 변수는 옵셔널이기 때문에 초기 값이 nil

john = Customer(name: "John Appleseed")
john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)

//  Customer 인스턴스를 생성하고 이를 사용하여 해당 고객의 카드 속성으로 새 CreditCard 인스턴스를 초기화하고 할당할 수 있음
```

이를 그림으로 나타내면

![img1](https://docs.swift.org/swift-book/images/unownedReference01~dark@2x.png)

이제 Customer 인스턴스에는 CreditCard 인스턴스에 대한 **강한 참조**가 있고 CreditCard 인스턴스에는 Customer 인스턴스에 대한 **미소유 참조**가 존재

미소유 고객 참조로 인해 john 변수가 보유한 강력한 참조를 해제하면 Customer 인스턴스에 대한 강한 참조가 더 이상 없음

![img2](https://docs.swift.org/swift-book/images/unownedReference02~dark@2x.png)

**Customer 인스턴스에 대한 강한 참조가 더 이상 없기 때문에 할당이 취소**

이 일이 발생하면 CreditCard 인스턴스에 대한 강력한 참조가 더 이상 없으며 역시 할당이 해제 됨

```swift
john = nil
// "John Appleseed is being deinitialized"
// "Card #1234567890123456 is being deinitialized"
```

위 예의 과정은 안전한 **미소유 참조**를 사용하는 방법을 보여줌

TODO: 옵셔널 미소유참조, 에러 관계

## 참고

[공식문서 - automaticreferencecounting](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/)

[블로그 참조](https://babbab2.tistory.com/27)
