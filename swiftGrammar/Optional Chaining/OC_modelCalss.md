## Defining Model Classes for Optional Chaining

> 프로퍼티, 메서드 및 스크립트에 대한 호출과 함께 옵셔널 체이닝을 사용 가능
> <br/>

이를 통해 상호 연관된 유형의 복잡한 모델 내에서 하위 속성을 드릴다운하고 해당 하위 속성의 속성, 메서드 및 하위 스크립트에 액세스할 수 있는지 여부를 확인이 가능
<br/>

즉 이에 따라 클래스를 선언시 이를 고려하여 선언할 수 있음
<br/>

```swift
class Room {
    let name: String
    init(name: String) { self.name = name }
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
```

<br/>

조금 더 복잡한 Model을 정의
<br/>

```swift
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
```

<br/>

buildingIdentifier 메소드는 주소의 프로퍼티를 확인하고 값이 있으면 BuildingName을 반환하고, 둘 다 값이 있으면 거리와 연결된 BuildingNumber를 반환하고, 그렇지 않으면 nil을 반환
<br/>

## 자료 출처

[swift 공식문서 -Optional Chaining-](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/optionalchaining/)
