## Accessing Properties Through Optional Chaining

> 강제 언래핑에 대한 대안으로서의 옵셔널 체이닝에서 설명한 대로 옵셔널 체이닝을 사용하여 옵셔널 값의 프로퍼티에 액세스하고 해당 프로퍼티 액세스가 성공적인지 확인할 수 있음
> <br/>

[Optional Chaining](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/Optional%20Chaining/README.md)을 배울 때 사용했던 예제 코드는 무조건 값이 없다고 뜰 것
<br/>

```swift
let john = Person()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
```

<br/>

방 수를 알고 싶으면 구문을 추가해야함
<br/>

```swift
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress // 옵셔널 체이닝
```

<br/>

이 예에서는 john.residence가 현재 nil이기 때문에 john.residence의 주소 속성을 설정하려는 시도가 실패 할 것
<br/>

할당은 옵셔널 체이닝의 일부, 즉, = 연산자의 오른쪽에 있는 코드에 반영 X
<br/>

이전 예에서는 상수에 액세스해도 부작용이 없기 때문에 someAddress가 반영되지 않는다는 것을 쉽게 알 수 없음
<br/>

아래 목록은 동일한 할당을 수행하지만 주소를 생성하는 함수를 사용해야함
<br/>

이 함수는 값을 반환하기 전에 "함수가 호출되었습니다"를 print = 연산자의 오른쪽이 반영 되었는지 확인이 가능
<br/>

```swift
func createAddress() -> Address {
    print("Function was called.")


    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"


    return someAddress
}

john.residence?.address = createAddress() // 옵셔널 체이닝
```

## 자료 출처

[swift 공식문서 -Accessing Properties Through Optional Chaining-](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/optionalchaining/#Accessing-Properties-Through-Optional-Chaining)
