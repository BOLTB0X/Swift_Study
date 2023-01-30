import UIKit

// guard(빠른종료- Early Exit)
// guard를 사용하여 잘못된 값의 전달 시 특정 실행구문을 빠르게 종료
// 디버깅 모드 뿐만 아니라 어떤 조건에서도 동작
// guard의 else 블럭 내부에는 특정 코드블럭을 종료하는 지시어(return, break 등)가 꼭 있어야 함
// 타입 캐스팅, 옵셔널과도 자주 사용
// 그 외에도 단순 조건 판단 후 빠르게 종료할 때도 용이

func functionWithGuard(age: Int?) {
    
    guard let unwrappedAge = age,
        unwrappedAge < 130,
        unwrappedAge >= 0 else {
        print("나이값 입력이 잘못되었습니다")
        return
    }
    
    print("당신의 나이는 \(unwrappedAge)세입니다")
}

var count = 1

while true {
    guard count < 3 else {
        break
    }
    print(count)
    count += 1
}
// 1
// 2

func someFunction(info: [String: Any]) {
    guard let name = info["name"] as? String else {
        return
    }
    
    guard let age = info["age"] as? Int, age >= 0 else {
        return
    }
    
    print("\(name): \(age)")
}

someFunction(info: ["name": "jenny", "age": "10"])
someFunction(info: ["name": "mike"])
someFunction(info: ["name": "khl", "age": 10]) // khl: 10
