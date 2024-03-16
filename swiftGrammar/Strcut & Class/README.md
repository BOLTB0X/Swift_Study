# Strcut & Class

한줄 핵심 “Struct는 Value Type, Class는 Reference Type”

> 기본적으로 ‘Data Model’ 에선 Struct
> 모델링하는 모델의 ID를 제어해야하는 경우에 Class

## Struct

- Value Type(값 타입)
- 상속(Inheritance) X
- 구조체로 선언 된 프로퍼티는 변수에 넣어 지거나 함수로 전달 될 때, 값 자체가 그대로 복사되어 새로운 인스턴스로 할당
- 단순 Model 정의에 주로 쓰임

```swift
// 'person'이라는 구조체 선언
struct Person {
	var name: String
	var height: Int
};

var p1 = person(name: "이경헌", height: 177)
var p2 = p1 // p1의 값이 p2로 복사

p1.name = "삼경헌"
print(p1.name) // 삼경헌
print(p2.name) // 이경헌

// p1의 맴버를 변경해도 p2에는 반영이 안됌
```

즉 새로운 변수로 할당 → 서로 독립적인 관계(다른 변수에 영향 X)

## Class

- Reference Type(참조 타입)
- 상속(Inheritance) O
- 클래스로 선언된 인스턴스를 변수에 할당하거나 함수로 전달할 때, 값 자체가 복사되는 것이 아니라 참조(메모리 주소)가 전달
- 공유 데이터나 객체의 상태를 동시에 변경해야 하는 경우에 주로 쓰임

```swift
class Person {
    var name: String
    var height: Int

    init(name: String, height: Int) {
        self.name = name
        self.height = height
    }
}

var p1 = Person(name: "이경헌", height: 177)
var p2 = p1 // p1의 참조가 p2로 복사됨

p1.name = "삼경헌"
print(p1.name) // 삼경헌
print(p2.name) // 삼경헌

// p1과 p2는 종속? 연결되어 있음
```

즉 클래스로 선언된 프로퍼티들의 맴버를 변경하면 참조 했던 여러 변수가 동일한 값을 가지게 됨 → 인스턴스의 참조 값이 그대로 전달

## 메모리

전공 관련 글을 읽다보면 값 타입, 참조 타입이라는 말이 나왔으면 Struct와 Class는 메모리가 다른 곳에 할당되고 다르게 사용한다는 뜻

- Struct (Stack 영역)

  각 스레드 독립적 → 어떤 스레드에서 구조체를 수정하더라도 다른 스레드에는 영향 X

- Class (Heap 영역)
  컴파일 단계에서 생성과 해제를 알 수 없는 참조 타입의 객체가 할당 → **순환 참조 발생 가능성:** 클래스 인스턴스 간에 서로 참조가 생기고, 이러한 참조가 순환 구조를 형성되어 문제가 야기 되어버림

## 적절한 사용은?

특별한 상황이 아니라면 Struct, 특별한 상황이라면 Class

- 단순 작업 → Struct

  - 연산/저장 프로퍼티, 메서드, 프로토콜 채택 등 Swift에선 구조체에서도 사용 가능
  - Swift의 표준 라이브러리의 Data들 또한 거의 구조체로 구현되어있음

- 상속을 받아야할 때 → Class
  - Objective-C의 API 상속
  - 객체들 간 유사성이 있을 때
  - ARC로 직접 메모리를 관리
  - 네트워크 연결 (REST API 요청)

## 참고

[공식문서 - Choosing Between Structures and Classes](https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes)

[블로그 참조 - [Swift] Class와 Struct의 차이점?](https://icksw.tistory.com/256)

[공식문서 - Inheritance](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/inheritance/)

[공식문서 - Structures and Classes](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/classesandstructures/)
