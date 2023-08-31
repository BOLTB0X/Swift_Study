//
//  main.swift
//  Optional Chaining
//
//  Created by KyungHeon Lee on 2023/08/31.
//

import Foundation

class Person {
    var residence: Residence?
}


class Residence {
    var numberOfRooms = 1
}

// 에러 발생
let john = Person()
// Person의 residence의 numberOfRooms 프로퍼티에 액세스하려고 하면 Residence 뒤에 느낌표를 배치하여 값을 강제로 언래핑하면 런타임 오류가 발생 -> 언래핑할 Residence 값이 없기 때문

let roomCount = john.residence!.numberOfRooms // 런타임 에러 발생

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// "Unable to retrieve the number of rooms." 으로 출력 됌

john.residence = Residence()

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Prints "John's residence has 1 room(s)."
