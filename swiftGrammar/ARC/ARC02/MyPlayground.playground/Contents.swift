import UIKit

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

john!.apartment = unit4A
unit4A!.tenant = john

john = nil
unit4A = nil
