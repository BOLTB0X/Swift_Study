struct Friend {
    var name : String
}

// 제내릭 <T>
// 재내릭으로 어떤 자료형아 들어올수 있도록 설정
struct MyArray<SomeElement> {

    // 맴버변수
    var elements = [SomeElement]()

    // 생성자 메소드
    // _ 앞에 언더바를 넣음으로서 매개변수 생략
    init (_ elements : [SomeElement]) {
        self.elements = elements
    }
}

var myIntegerArr = MyArray([1,2,3])
print("myIntegerArr : \(myIntegerArr)") // 1 2 3

var myStringArr = MyArray(["a","b","c"])
print("myStringArr : \(myStringArr)") // a b c

// 구조체와 재네릭
let first_fri = Friend(name : "l")
let sec_fri = Friend(name : "k")
let thir_fri = Friend(name : "h")

var myFriendArr = MyArray(first_fri, sec_fri, thir_fri)
print("myFriendArr : \(myFriendArr)")