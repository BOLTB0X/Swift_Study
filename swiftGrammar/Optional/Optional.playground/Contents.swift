import Foundation

let shortForm: Int? = Int("42")
let longForm: Optional<Int> = Int("42")

let number: Int? = Optional.some(42)
let noNumber: Int? = Optional.none
print(noNumber == nil)

let a: Int? = 4
if let tmp = a {
   // a가 nil이 아닐 때
   print(tmp)
} else {
   // a가 nil일 때
   print(a!)
}

// guard 조건을 만족하지 못하면 함수 내로 들어오지 못하도록 "막는" 역할!
func funcGuard(age: Int?) {
    guard let unwrappedAge = age,
        unwrappedAge < 130,
        unwrappedAge >= 0 else {
        print("나이값 입력이 잘못되었습니다")
        return
    }
    
    print("당신의 나이는 \(unwrappedAge)세입니다")
}

func functest(_ name: String?, _ age: Int?) {
   guard let name = name, let age = age, age < 5 else {
      return
   }
}

//var num1: Int? = 4
//var num2: Int = num1
// 에러 발생
// 옵셔널 타입을 옵셔널이 아닌 타입에 대입하려 하기 때문

var num3: Int! = 4 // IUO 사용
var num4: Int = num3 // num2의 값은 4이다
// 정상 작동 -
// IUO를 사용했기 때문
