import UIKit

var greeting = "Hello, playground"

// for문 구조
//for item in items {
//    /* 실행 구문 */
//}

var integers = [1, 2, 3]
let people = ["yagom": 10, "eric": 15, "mike": 12]

for integer in integers {
    print(integer)
}

// Dictionary의 item은 key와 value로 구성된 튜플 타입입니다
for (name, age) in people {
    print("\(name): \(age)")
}

// while문 구조
//while 조건 {
//    /* 실행 구문 */
//}

while integers.count > 1 {
    integers.removeLast()
}

//repeat-while 구문
//repeat {
//    /* 실행 구문 */
//} while 조건

repeat {
    integers.removeLast()
} while integers.count > 0
