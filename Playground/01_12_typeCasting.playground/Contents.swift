import UIKit

/* 타입캐스팅 */

// 스위프트의 타입캐스팅은 인스턴스의 타입을 확인하는 용도
// 또는 클래스의 인스턴스를
// 부모 혹은 자식 클래스의 타입으로 사용할 수 있는지 확인하는 용도로 사용
// is, as를 사용

// 타입 캐스팅을 위한 클래스 정의
class Person {
    var name: String = ""
    func breath() {
        print("숨을 쉽니다")
    }
}

class Student: Person {
    var school: String = ""
    func goToSchool() {
        print("등교를 합니다")
    }
}

class UniversityStudent: Student {
    var major: String = ""
    func goToMT() {
        print("멤버쉽 트레이닝을 갑니다!")
    }
}

var kh2: Person = Person()
var kh3: Student = Student()
var kh4: UniversityStudent = UniversityStudent()


//MARK: - 타입 확인
// is를 사용하여 타입을 확인합니다
var result: Bool

result = kh2 is Person // true
result = kh2 is Student // false
result = kh2 is UniversityStudent // false
result = kh2 is Person // true
result = kh3 is Student // true
result = kh3 is UniversityStudent // false
result = kh4 is Person // true
result = kh4 is Student // true
result = kh4 is UniversityStudent // true
if kh2 is UniversityStudent {
    print("kh2은 대학생입니다")
} else if kh2 is Student {
    print("kh2은 학생입니다")
} else if kh2 is Person {
    print("kh2은 사람입니다")
} // kh2은 사람입니다
switch kh4 {
case is Person:
    print("kh4은 사람입니다")
case is Student:
    print("kh4은 학생입니다")
case is UniversityStudent:
    print("kh4은 대학생입니다")
default:
    print("kh4은 사람도, 학생도, 대학생도 아닙니다")
} // kh4은 사람입니다
switch kh4 {
case is UniversityStudent:
    print("kh4은 대학생입니다")
case is Student:
    print("kh4은 학생입니다")
case is Person:
    print("kh4은 사람입니다")
default:
    print("kh4은 사람도, 학생도, 대학생도 아닙니다")
} // kh4은 대학생입니다
//MARK: - 업 캐스팅
// as를 사용하여 부모클래스의 인스턴스로 사용할 수 있도록
// 컴파일러에게 타입정보를 전환해줍니다
// Any 혹은 AnyObject로도 타입정보를 변환할 수 있습니다
// 암시적으로 처리되므로 생략해도 무방합니다
var mike: Person = UniversityStudent() as Person
var jenny: Student = Student()
//var jina: UniversityStudent = Person() as UniversityStudent // 컴파일 오류
var jina: Any = Person() // as Any 생략가능

//MARK: - 다운 캐스팅
// as? 또는 as!를 사용하여
// 자식 클래스의 인스턴스로 사용할 수 있도록
// 컴파일러에게 인스턴스의 타입정보를 전환해줍니다
//MARK: 조건부 다운 캐스팅
// as?
var optionalCasted: Student?

optionalCasted = mike as? UniversityStudent
optionalCasted = jenny as? UniversityStudent // nil
optionalCasted = jina as? UniversityStudent // nil
optionalCasted = jina as? Student // nil

//MARK: 강제 다운 캐스팅
// as!
var forcedCasted: Student

optionalCasted = mike as! UniversityStudent
//optionalCasted = jenny as! UniversityStudent // 런타임 오류
//optionalCasted = jina as! UniversityStudent // 런타임 오류
//optionalCasted = jina as! Student // 런타임 오류

// 활용
func doSomethingWithSwitch(someone: Person) {
    switch someone {
    case is UniversityStudent:
        (someone as! UniversityStudent).goToMT()
    case is Student:
        (someone as! Student).goToSchool()
    case is Person:
        (someone as! Person).breath()
    }
}

doSomethingWithSwitch(someone: mike as Person) // 멤버쉽 트레이닝을 갑니다!
doSomethingWithSwitch(someone: mike) // 멤버쉽 트레이닝을 갑니다!
doSomethingWithSwitch(someone: jenny) // 등교를 합니다
doSomethingWithSwitch(someone: kh2) // 숨을 쉽니다

func doSomething(someone: Person) {
    if let universityStudent = someone as? UniversityStudent {
        universityStudent.goToMT()
    } else if let student = someone as? Student {
        student.goToSchool()
    } else if let person = someone as? Person {
        person.breath()
    }
}

doSomething(someone: mike as Person) // 멤버쉽 트레이닝을 갑니다 신남!
doSomething(someone: mike) // 멤버쉽 트레이닝을 갑니!
doSomething(someone: jenny) // 등교를 합니다
doSomething(someone: kh2) // 숨을 쉽니다
