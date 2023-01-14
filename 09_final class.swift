// final 키워드로 다른 클래스가 상속받지 못함
final class Frined {
    var name : String
    init(name : String) {
        self.name = name
    }
}

// Friend로 상속을 하였지만 컴파일 에러
class BestFriend : Frined {
    override init(name : String) {
        super.init(name : "베프" + name)
    }
}

let myFriend = Friend(name : "철수")
print("myFriend : \(myFriend.name)")

let myBF = Friend(name : "수잔")
print("myBF : \(myBF.name)")