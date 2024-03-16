## Generic

> Generic은 타입에 대한 추상화를 제공

### Generic은 왜 쓸까

```swift
func add(_ a: Int, _ b : Int) -> Int {
    return a + b
}

func add(_ a: Double, _ b : Double) -> Double {
    return a + b
}

func add(_ a: String, _ b : String) -> String {
    return a + b
}
```

이렇게 파리미터와 타입별 로 전부 하나씩 ~~노가다~~ 구현할 수 없으니 이럴 때 쓰는 것

### Generic Type

> ‘**중복을 피하고 명확하고 추상적인 방식으로 의도를 표현하는 코드’**

- 타입 안정성(Type Safety)
- 코드 재사용성
- 효율적인 코딩

> **Swift 표준 라이브러리의 대부분은 제네릭 코드로 구축되었습니다.
> Swift의 Array 및 Dictionary 유형은 모두 일반 컬렉션입니다.**

공식문서의 영향으로? 대부분 Generic Type을 설명할 때 Swap(두 원소의 위치를 변경)으로 주로 설명

```swift
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let tmp = a
    a = b
    b = tmp
}

// cf. inout
// 해당 파라미터의 값을 함수 로컬 밖에도 변경한게 유지되도록 하고 싶을 때 씀

var integerArr = [5, 3, 2, 0]
swapTwoInts(&integerArr[0], &integerArr[1]) // 가능

var doubleArr = [5.0, 4.3, 3.2, 1,2] // ???
```

Double형 말고도 String, Character 등 여러 타입용 함수를 정성껏 만들기가 위에 작성해 놓은 ‘코드 재사용’, ‘효율적인 코딩’에 위배

```swift
// 제네릭 버전
// 제네릭을 적용할 함수 이름<타입 매개변수>
// or 제네릭을 적용할 타입 이름<타입 매개변수>
func swap<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

// double도 가능
```

또한 swift로 코딩을 하다가 Array<Element>, Dictionary<Key, Value> 본 이것들이 ‘Generic’이 였던 것

## 참고

[Swift 공식문서 - Generic](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics/)
