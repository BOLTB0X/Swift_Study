## Accessing Subscripts Through Optional Chaining

> 옵셔널 체이닝을 사용하면 옵셔널 값의 첨자에서 값을 검색 및 설정하고 해당 첨자 호출 가능

아래 예제에서는 Residence 클래스에 정의된 아래 첨자를 사용하여 john.residence 프로퍼티의 Rooms 배열에서 첫 번째 방의 이름을 검색하려고 시도한다면?
<br/>

```swift
if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// 출력 "Unable to retrieve the first room name."
```

<br/>

john.residence는 현재 nil이므로 아래 첨자 호출이 실패
<br/>

이 첨자 호출에서 선택적 연결 물음표는 john.residence 바로 뒤, 첨자 대괄호 앞에 배치됨
<br/>

왜냐하면 john.residence는 옵셔널 체이닝이 시도되는 옵셔널 값이기 때문
<br/>

옵셔널 체이닝을 사용하여 아래 첨자를 통해 새 값을 설정할 수 있음
<br/>

```swift
john.residence?[0] = Room(name: "Bathroom")
```

<br/>

현재 residence가 없기 때문에 이 첨자 설정 시도도 실패
<br/>

실제 Residence 인스턴스를 생성하여 john.residence에 할당하고 Romm 배열에 하나 이상의 Room 인스턴스를 할당하는 경우
<br/>

Residence 첨자를 사용하여 옵셔널 체이닝을 통해 Room 배열의 실제 항목에 액세스할 수 있음
<br/>

```swift
let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse


if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// 출력 "The first room name is Living Room."
```

## 자료 출처

[swift 공식문서 -Accessing Subscripts Through Optional Chaining-](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/optionalchaining/#Accessing-Subscripts-Through-Optional-Chaining)
