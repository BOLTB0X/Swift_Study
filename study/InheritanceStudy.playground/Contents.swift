import Foundation

// 기본 클래스
class Human {
    var field: String?
    var age: Int?
}

// 서브클래싱
class Coder: Human { // class Human의 속한 프로퍼티들도 싹다 사용 가능
    var noteBook: String?
}

let lkh: Coder = .init()
lkh.field = "iOS"
lkh.noteBook = "mac!"
print(lkh.field!)
print(lkh.noteBook!)

// final
final class Human2 {
    var field: String?
    var age: Int?
    
    func description() {
        
    }
}

class Human3 {
    var field: String?
    var age: Int?
    
    func description() {
    }
}

// 오버라이딩
class Coder2: Human3 {
    override func description() {
        print("iOS 개발공부중")
    }
}

let threekh: Human3 = .init()
threekh.age = 30
threekh.field = "iOS"

let test: Coder2 = .init()
print(test.description())
