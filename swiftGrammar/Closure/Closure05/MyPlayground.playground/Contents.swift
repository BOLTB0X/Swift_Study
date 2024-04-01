import UIKit

func doFunc() {
    var num: Int = 0
    print("num 확인 #1 = \(num)")
    
    let closure = { [num] in
        print("num 확인 #3 = \(num)")
    }
    
    num = 20
    print("num 확인 #2 = \(num)")
    closure()
}

doFunc()
//num 확인 #1 = 0
//num 확인 #2 = 20
//num 확인 #3 = 0

class StrongClass {
    var value = 0
    
    func doSomething() {
        let closure = {
            print(self.value)
        }
        
        closure() // 클로저가 강한 참조로 self를 캡처하므로 self의 인스턴스를 사용할 수 있음
    }
}

let sObj = StrongClass()
sObj.doSomething() // 0

class WeekClass {
    var value: Int
    
    init() {
        self.value = 10
        print("WeakClass 객체가 생성됨")
    }
    
    init(value: Int) {
        self.value = value
        print("WeakClass 객체가 생성됨")
    }
        
    deinit {
        print("WeakClass 객체가 해제됨")
    }
    
    lazy var doSay: () -> String = { [weak self] in
        "\(self) !!!"
    }
    
    func doSomething() {
        // 약한 참조로 self를 캡처하는 클로저
        let closure = { [weak self] in
            if let self = self {
                print(self.value)
            } else {
                print("객체가 이미 해제됨")
            }
        }
        
        closure() // weak 참조로 self를 캡처하므로 self의 인스턴스가 해제되어도 클로저가 실행됨
    }
}

var wObj: WeekClass? = WeekClass()
wObj!.doSomething() // 10

class UnownedClass {
    var value: Int
    
    init() {
        self.value = 10
        print("UnownedClass 객체가 생성됨")
    }
    
    init(value: Int) {
        self.value = value
        print("UnownedClass 객체가 생성됨")
    }
        
    deinit {
        print("UnownedClass 객체가 해제됨")
    }
    
    lazy var doSay: () -> String = { [unowned self] in
        "\(self) !!!"
    }
    
    func doSomething() {
        // 미소유 참조로 self를 캡처하는 클로저
        let closure = { [unowned self] in
            print(self.value)
        }
        
        closure() // 클로저가 미소유 참조로 self를 캡처하므로 self의 인스턴스가 해제되면 런타임 에러가 발생함
    }
}

var uObj: UnownedClass? = UnownedClass()
uObj!.doSomething() // 0

uObj?.doSay = wObj?.doSay ?? { "~~~" } // uObj의 value를 wObj의 프로퍼티로 참조 할당

// 객체 해제
uObj = nil
//uObj = nil
// WeakClass 객체가 해제됨
// UnownedClass 객체가 해제됨

print(uObj?.doSay)
print(wObj?.doSay)
