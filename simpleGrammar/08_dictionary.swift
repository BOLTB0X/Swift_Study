// 키 값으로 한  쌍ㅣ 딕셔너리 - 사물함과 비ㅅ
var myFriends = [
                "BF" : "3kh",
                "high" : "4kh"
]

// BF 라는 열쇠로 내용물을 꺼냄
if let myBF = myFriends["BF"] {
    print(myBF)
}

// 값을 꺼낼때 찾는 키로 저장된 값이 없다면
// default 값을 가져오도록 설정 가능
let myFriend = myFriends["hohoBF", default: "친구X"]
print(myFriend)

// 값 추가 및 변경 가능
myFriends["hoho"] = "호호"

let someValue = myFriends["hoho", default : "친구X"]
print(someValue)

// 값 추가 및 변경 가능
myFriends.updateValue("하", forKey : "hoho")

let hoho = myFriends["hoho", default: "친구X"]
print(hoho)

// 이런식으로 빈 딕셔너리도 생성 가능 (키, 값 자료형)
let emptyDictionary = [String : Int]
let myEmptyDic = Dictionary<<String, Int> ()
