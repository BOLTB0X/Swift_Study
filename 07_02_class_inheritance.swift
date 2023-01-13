import Foundation

class Friend {
    var name : String

    init(_ name : String) {
        self.name = name
    }

    func sayHi() {
        print("hi my name is \(self.name)")
    }
}

class BestFriend : Friend {
    // override 를 통해 부모 클래스의 메소드를 가져온다
    override init(_ name : String) {
        // super 키워드로 부모의 메소드를 사용
        super.init("best friend is" + name)
    }

    override func sayHi() {
        super.sayHi()
    }
}

let myFriend = Friend("coco")

myFriend.sayHi()

let myBestFriend = BestFriend("jin")

myBestFriend.sayHi()