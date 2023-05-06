import UIKit

class Person {
    let name: String

    // MARK: - 1. initializer
    init(name: String) {
        self.name = name
        // 초기화를 나타내는 부분
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

// 선택적 유형이므로 자동으로 nil 값으로 초기화되며 현재 Person 인스턴스를 참조 X
var reference1: Person?

// MARK: -2.
// referencel 는 스택영역에 할당
// Person은 힙영역에 할당
reference1 = Person(name: "John Appleseed") // John Appleseed is being initialized

let cloneRef = reference1
