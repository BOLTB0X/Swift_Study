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
