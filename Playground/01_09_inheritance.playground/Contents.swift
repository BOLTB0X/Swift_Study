import UIKit

//상속은 클래스, 프로토콜 등에서 가능
//열거형, 구조체는 상속이 불가능
//스위프트의 클래스는 단일상속으로, 다중상속을 지원 X

// 기반 클래스 Person
class Person {
    var name: String = ""
    
    func selfIntroduce() {
        print("저는 \(name)입니다")
    }
    
    // final 키워드를 사용하여 재정의를 방지할 수 있습니다
    final func sayHello() {
        print("hello")
    }
    
    // 타입 메서드
    // 재정의 불가 타입 메서드 - static
    static func typeMethod() {
        print("type method - static")
    }
    
    // 재정의 가능 타입 메서드 - class
    class func classMethod() {
        print("type method - class")
    }
    
    // 재정의 가능한 class 메서드라도
    // final 키워드를 사용하면 재정의 할 수 없습니다
    // 메서드 앞의 `static`과 `final class`는 똑같은 역할을 합니다
    final class func finalCalssMethod() {
        print("type method - final class")
    }
}

// Person을 상속받는 Student
class Student: Person {
    var major: String = ""
    
    override func selfIntroduce() {
        print("저는 \(name)이고, 전공은 \(major)입니다")
    }
    
    override class func classMethod() {
        print("overriden type method - class")
    }
    
    // static을 사용한 타입 메서드는 재정의 할 수 없습니다
//    override static func typeMethod() {    }
    
    // final 키워드를 사용한 메서드, 프로퍼티는 재정의 할 수 없습니다
//    override func sayHello() {    }
//    override class func finalClassMethod() {    }

}

let kh2: Person = Person()
let kh3: Student = Student()

kh2.name = "kh2"
kh3.name = "kh3"
kh3.major = "Swift"

kh2.selfIntroduce()
// 저는 kh2입니다

kh3.selfIntroduce()
// 저는 kh3이고, 전공은 Swift입니다

Person.classMethod()
// type method - class

Person.typeMethod()
// type method - static

Person.finalCalssMethod()
// type method - final class


Student.classMethod()
// overriden type method - class

Student.typeMethod()
// type method - static

Student.finalCalssMethod()
// type method - final class
