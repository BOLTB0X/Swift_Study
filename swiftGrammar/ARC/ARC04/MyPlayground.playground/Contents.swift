import UIKit

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
// 이 두 클래스는 각각 다른 클래스의 인스턴스를 속성으로 저장합니다. 이 관계는 강력한 참조 순환을 만들 가능성이 있음

var john: Customer?

// 특정 Customer에 대한 참조를 저장하는 데 사용되는 john이라는 옵셔널 고객 변수를 정의
// 이 변수는 옵셔널이기 때문에 초기 값이 nil

john = Customer(name: "John Appleseed")
john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)

//  Customer 인스턴스를 생성하고 이를 사용하여 해당 고객의 카드 속성으로 새 CreditCard 인스턴스를 초기화하고 할당할 수 있음

john = nil
// "John Appleseed is being deinitialized"
// "Card #1234567890123456 is being deinitialized"
