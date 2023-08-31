# Optional Chaining

> Access members of an optional value without unwrapping.
> <br/>
> 래핑을 해제하지 않고 옵셔널 값의 멤버에 액세스합니다.
> <br/>

Optional chaining is a process for querying and calling properties, methods, and subscripts on an optional that might currently be nil..........
<br/>

공식 문서의 옵셔널 체이닝가 무엇인지 간략히 나타내 보면
<br/>

**현재 nil일 수도 있는 옵셔널 프로퍼티, 함수, 서브스크립트를 참조하고 호출하는 과정** 이고
<br/>

만약 옵셔널이 값을 가지고 있다면 프로퍼티, 메서드, 서브스크립트는 성공적으로 호출되고
<br/>

만약 nil이라면 nil을 반환,
<br/>

다중 질의도 함께 chaining 될 수 있으며, 만약 하나라도 nil이라면 전체 chain이 실패
<br/>

## !과 ? 차이: Optional Chaining as an Alternative to Forced Unwrapping

옵셔널이 nil이 아닌 경우 속성, 메소드 또는 서브스크립트를 호출하려는 옵셔널 값 뒤에 물음표(?)를 배치하여 옵셔널 체이닝을 지정할수 있음
<br/>

이는 해당 값을 강제로 풀기 위해 옵셔널 값 뒤에 느낌표(!)를 사용하는 것과 매우 유사
<br/>

주요 차이점은
<br/>

- **_?_**: 옵셔널이 nil일 때 옵셔널 체이닝이 정상적으로 그냥 안 되는 것

- **_!_**: 옵셔널이 nil일 때 강제 언래핑은 런타임 오류를 발생시킨다는 것

nil 값에 대해 옵셔널 연결을 호출할 수 있다는 사실을 반영하기 위해, 옵셔널 연결 호출의 결과는 쿼리하는 속성, 메서드 또는 첨자가 옵셔널 값이 아닌 값을 반환하는 경우에도 항상 옵셔널 값
<br/>

이 옵셔널 반환 값을 사용하여 선택적 연결 호출이 성공했는지(반환된 선택적 값에 값이 포함되어 있는지) 체인의 nil 값으로 인해 성공하지 않았는지(반환된 옵셔널 값은 nil인지) 확인할 수 있는 게 **Optional Chaining**
<br/>

코드로 설명해보면
<br/>

```swift
class Person {
    var residence: Residence?
}


class Residence {
    var numberOfRooms = 1
}

```

<br/>

Residence 인스턴스에는 numberOfRooms라는 단일 Int 속성이 있으며 기본값은 1
</br>
Person 인스턴스에는 Residence? 유형의 옵셔널 프로퍼티

```swift
let john = Person() // 에러 발생
```

<br/>

Person의 residence의 numberOfRooms 프로퍼티에 액세스하려고 하면 Residence 뒤에 느낌표를 배치하여 값을 강제로 언래핑하면 런타임 오류가 발생 -> **언래핑할 Residence 값이 없기 때문**
<br/>

```swift
let roomCount = john.residence!.numberOfRooms // 런타임 에러 발생
```

<br/>

위의 코드는 john.residence에 nil이 아닌 값이 있을 때(Int 값으로 값이 넣어져있을 때) -> **런타임 에러 X**
<br/>

하지만 residence의 값이 nil인 경우 -> **런타임 에러 O**
<br/>

**옵셔널 체이닝은 numberOfRooms 값에 액세스하는 대체 방법을 제공하는 것이므로 옵셔널 체이닝을 사용하려면 ! 대신 ?를 사용**
<br/>

```swift
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
```

<br/>

값이 없으니 "Unable to retrieve the number of rooms." 으로 출력 됌
<br/>

```swift
john.residence = Residence()
```

john.residence에는 이제 nil이 아닌 실제 Residence 인스턴스를 넣어줌
<br/>

이전과 동일한 옵셔널 체이닝을 사용하여 numberOfRooms에 액세스하려고 하면 이제 Int? 기본 numberOfRooms 값 1을 포함되어져 있음
<br/>

```swift
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
```

<br/>

John's residence has 1 room(s).으로 출력 됌
<br/>

## 케이스 별 Optional Chaining

- ['옵셔널 체이닝을 위한 모델 클래스 정의' 보기]()

- ['옵셔널 체이닝을 통해 프로퍼타에 접근' 보기]()

- ['옵셔널 체이닝을 통한 메서드 호출' 보기]()

- ['옵셔널 체이닝을 통한 서브스크립트 접근' 보기]()

- ['옵셔널 타입의 서브스크립트 접근' 보기]()

## 자료 출처

[swift 공식문서 -Optional Chaining-](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/optionalchaining/)
