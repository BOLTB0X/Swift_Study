import UIKit

struct Human {
    static let name = "B0X" // 스태틱 변수로 data영역에 할당
}

var part: String? // 전역 변수로 데이터 영역에 할당
var age: Int? // 전역 변수로 데이터 영역에 할당

func addFunc(_ a:Int, _ b:Int) -> Int { // 파라미터는 스택에 할당
    let ret = a + b // local 변수 또한 스택에 할당
    
    return ret
}

// addFunc 함수가 종료되는 시점에 스택에 저장된 메모리는 자동으로 반환됨
print(addFunc(5,4))
