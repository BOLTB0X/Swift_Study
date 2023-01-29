import UIKit

//MARK: - 프로퍼티 기본값
// 스위프트의 모든 인스턴스는 초기화와 동시에
// 모든 프로퍼티에 유효한 값이 할당되어 있어야 합니다
// 프로퍼티에 미리 기본값을 할당해두면
// 인스턴스가 생성됨과 동시에 초기값을 지니게 됩니다
class PersonA {
    // 모든 저장 프로퍼티에 기본값 할당
    var name: String = "unknown"
    var age: Int = 0
    var nickName: String = "box"
}

let jason: PersonA = PersonA()
jason.name = "kh2"
jason.age = 30
jason.nickName = "b"

//MARK: - 이니셜라이저
// 프로퍼티 기본값을 지정하기 어려운 경우에는 이니셜라이저를 통해
// 인스턴스가 가져야 할 초기값을 전달 가능
class PersonB {
    var name: String
    var age: Int
    var nickName: String
    
    // 이니셜라이저
    init(name: String, age: Int, nickName: String) {
        self.name = name
        self.age = age
        self.nickName = nickName
    }
}

let hana: PersonB = PersonB(name: "kh", age: 30, nickName: "box")

//let hana: PersonB = PersonB(name: "hana", age: 20, nickName: "")

//MARK: 프로퍼티의 초기값이 꼭 필요 없을 때
// 옵셔널을 사용
class PersonC {
    var name: String
    var age: Int
    var nickName: String?
    
    init(name: String, age: Int, nickName: String) {
        self.name = name
        self.age = age
        self.nickName = nickName
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let jenny: PersonC = PersonC(name: "kkk", age: 30)
let mike: PersonC = PersonC(name: "khh", age: 35, nickName: "m")

// 암시적 추출 옵셔널은 인스턴스 사용에 꼭 필요하지만
// 초기값을 할당하지 않고자 할 때 사용
class Puppy {
    var name: String
    var owner: PersonC!
    
    init(name: String) {
        self.name = name
    }
    
    func goOut() {
        print("\(name)가 주인 \(owner.name)와 산책을 합니다")
    }
}

let happy: Puppy = Puppy(name: "happy")
//happy.goOut() // 주인이 없는 상태라 오류 발생
happy.owner = jenny
happy.goOut()
// happy가 주인 jenny와 산책을 합니다

//MARK: 실패가능한 이니셜라이저
// 이니셜라이저 매개변수로 전달되는 초기값이 잘못된 경우
// 인스턴스 생성에 실패 가능
// 인스턴스 생성에 실패하면 nil을 반환
// 그래서 실패가능한 이니셜라이저의 반환타입은 옵셔널 타입
class PersonD {
    var name: String
    var age: Int
    var nickName: String?
    
    init?(name: String, age: Int) {
        if (0...120).contains(age) == false {
            return nil
        }
        
        if name.characters.count == 0 {
            return nil
        }
        
        self.name = name
        self.age = age
    }
}

//let john: PersonD = PersonD(name: "john", age: 23)
let john: PersonD? = PersonD(name: "khh", age: 23)
let joker: PersonD? = PersonD(name: "jjj", age: 123)
let batman: PersonD? = PersonD(name: "", age: 10)

print(joker) // nil
print(batman) // nil
//MARK: - 디이니셜라이저
// deinit은 클래스의 인스턴스가 메모리에서 해제되는 시점에 호출
// 인스턴스가 해제되는 시점에 해야할 일을 구현 가능
class PersonE {
    var name: String
    var pet: Puppy?
    var child: PersonC
    
    init(name: String, child: PersonC) {
        self.name = name
        self.child = child
    }
    
    deinit {
        if let petName = pet?.name {
            print("\(name)가 \(child.name)에게 \(petName)를 인도합니다")
            self.pet?.owner = child
        }
    }
}

var donald: PersonE? = PersonE(name: "donald", child: jenny)
donald?.pet = happy
donald = nil // donald 인스턴스가 더이상 필요없으므로 메모리에서 해제
// donald가 jenny에게 happy를 인도
