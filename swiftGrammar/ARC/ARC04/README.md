# Unowned References(비소유 참조)

> 비소유 참조는 참조하는 인스턴스를 강하게 유지하지 않음

- **약한 참조**와 달리 **비소유 참조** 는 다른 인스턴스의 수명이 같거나 더 긴 경우에 사용

- **약한 참조**와 달리 **비소유 참조** 는 항상 값을 가질 것으로 예상 -> `nil`로 선언하지 않음

- 참조가 항상 할당 해제되지 않은 인스턴스를 참조한다고 확신하는 경우에만 **비소유 참조(Unowned References)** 를 사용

---

## 강한 순환 참조(Strong Reference Cycles) 가 발생한 경우

```swift
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
```

- 이 두 클래스는 각각 다른 클래스의 인스턴스를 프로퍼티가 저장

- 이 관계는 **강한 참조 순환** 을 생성 가능성이 있음

---

## 클래스 간의 관계

> `Customer` 와 `CreditCard` 간의 관계는 [약한 참조](https://github.com/BOLTB0X/Swift_Study/tree/main/swiftGrammar/ARC/ARC03) 에서 본 `Apartment` 와 `Person` 간의 관계와 약간 다름

- `Customer` (고객)은 신용카드를 가지고 있을 수도 있고, 없을 수도 있음 -> `card`: 옵셔널

- `CreditCard` (신용카드)는 반드시 어떤 고객에 속해 있어야 함 -> `customer`: `non-optional` , `unowned`

- `weak` 와 반대로 둘 중에 수명이 더 긴 인스턴스를 가리키는 인스턴스를 `unowned` (비소유) 참조로 선언

---

## 비소유 참조 사용

1. `Customer` 인스턴스를 생성하고 이를 사용하여 해당 `Customer`의 `card` 프로퍼티로 새 `CreditCard` 인스턴스를 초기화하고 할당

    ```swift
    john = Customer(name: "John Appleseed")
    john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)
    ```

    <p align="center">
        <img src="https://docs.swift.org/swift-book/images/org.swift.tspl/unownedReference01@2x.png" alt="Example Image" width="80%">
    </p>

    `Customer` 인스턴스에는 `CreditCard` 인스턴스에 대한 **강한 참조**가 있고 `CreditCard` 인스턴스에는 `Customer` 인스턴스에 대한 **비소유 참조**가 존재

    ---

2. `Customer` 의 **비소유 참조** 로 인해 `john`의 **강한 참조** 를 해제하면, `Customer` 인스턴스에 대한 **강한 참조** 가 해제 됌

    <p align="center">
        <img src="https://docs.swift.org/swift-book/images/org.swift.tspl/unownedReference02@2x.png" alt="Example Image" width="80%">
    </p>
    
    
    - `Customer` 인스턴스에 대한 **강한 참조** 가 더 이상 없기 때문에 할당이 취소
    
    - 이런게 발생하면 `CreditCard` 인스턴스에 대한 **강한 참조** 가 더 이상 없으며 역시 할당이 해제 됨


    ```
    [스택]
    john ─────────────┐
                      ↓
              ┌────────────────────┐
    [힙]      │ Customer           │
              │ card ─────┐        │
              └───────────↓────────┘
                          │ CreditCard
                          │ unowned customer
                            ->
                            Customer (참조 카운트 증가 X)
    ```

    ---

3. 참조 해제

    ```swift
    john = nil
    // "John Appleseed is being deinitialized"
    // "Card #1234567890123456 is being deinitialized"
    ```

---

TODO: 옵셔널 비소유참조, 에러 관계

## 참고

[공식문서 - automaticreferencecounting](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/)

[블로그 참조 - 개발자 소들이](https://babbab2.tistory.com/27)
