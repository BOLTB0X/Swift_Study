## Calling Methods Through Optional Chaining

> 사용하여 선택적 값에 대한 메서드를 호출하고 해당 메서드 호출이 성공하는지 확인할 수 있음
> <br/>
> 해당 메서드가 반환 값을 정의하지 않더라도 이 작업을 수행할 수 있음
> <br/>

Residence 클래스의 printNumberOfRooms() 메소드는 numberOfRooms의 현재 값을 print
<br/>

```swift
func printNumberOfRooms() {
    print("The number of rooms is \(numberOfRooms)")
}
```

이 메서드는 반환 타입을 지정해 놓지 X
<br/>

그러나 반환 값이 없는 함수에 설명된 대로 반환 타입이 없는 함수와 메서드에는 암시적(implicit) 반환 타입 Void가 있는데 이는 **()** 값 또는 빈 **튜플**을 반환한다는 의미
<br/>

옵셔널 체이닝을 통해 옵셔널 값에 대해 이 메서드를 호출하면 메서드의 반환 유형은 Void가 아닌 Void?가 된다는 것임
<br/>

왜냐하면 옵셔널 체이닝을 통해 호출할 때 반환 값은 항상 옵셔널 타입이기 때문
<br/>

이를 통해 메서드 자체가 반환 값을 정의하지 않더라도 if 문을 사용하여 printNumberOfRooms() 메서드를 호출할 수 있는지 여부를 확인할 수 있음
<br/>

printNumberOfRooms 호출의 반환 값을 nil과 비교하여 메서드 호출이 성공했는지 확인
<br/>

```swift
if john.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

// "It was not possible to print the number of rooms."
```

<br/>

옵셔널 체이닝을 통해 프로퍼티를 설정하려는 경우에도 마찬가지, 위의 옵셔널 체이닝을 통한 속성 액세스의 예에서는 residence 프로퍼티에 nil인 경우에도 john.residence에 대한 주소 값을 설정하려고 시도함
<br/>

옵셔널 체이닝을 통해 프로퍼티를 설정하려고 시도하면 Void? 타입의 값이 반환 되는 것.
<br/>

이를 통해 nil과 비교하여 프로퍼티가 성공적으로 설정되었는지 확인할 수 있음
<br/>

```swift
if (john.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}
// 출력 "It was not possible to print the number of rooms."
```

## 자료 출처

[swift 공식문서 -Calling Methods Through Optional Chaining-](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/optionalchaining/#Calling-Methods-Through-Optional-Chaining)
