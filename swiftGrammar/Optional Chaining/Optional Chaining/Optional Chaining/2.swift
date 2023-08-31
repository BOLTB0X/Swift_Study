//
//  2.swift
//  Optional Chaining
//
//  Created by KyungHeon Lee on 2023/08/31.
//

import Foundation

class Person {
    var residence: Residence?
}

class Residence {
    var rooms: [Room] = [] // Room 인스턴스 배열을 저장하기 때문에 numberOfRooms 속성은 저장 프로퍼티가 아닌 계산 프로퍼티로 구현
    var numberOfRooms: Int {
        return rooms.count // 계산된 numberOfRooms 프로퍼티가 단순히 객실 배열의 count 프로퍼티 값을 반환
    }

    // 방 배열에 액세스하는 지름길로 이 Residence 버전은
    // 방 배열의 요청된 인덱스에 있는 방에 대한 액세스를 제공하는 읽기-쓰기 첨자를 제공
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }

    // 또한 단순히 거주지에 있는 방의 수를 인쇄하는 printNumberOfRooms라는 메소드를 제공
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String? // 특정 건물을 주소의 일부로 식별
    var street: String?

    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

func createAddress() -> Address {
    print("Function was called.")


    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"


    return someAddress
}

