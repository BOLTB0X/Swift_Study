## Protocol

> **프로토콜은 특정 작업이나 기능에 적합한 함수, 프로퍼티 및 기타 요구 사항의 청사진을 정의**

### Protocol 정의

공식 문서의 설명 문구와 코드에 따르면, 함수, 프로퍼티 및 기타 요구 사항의 선언을 포함하며 정의

```swift
// 클래스, 구조 및 열거형과 비슷하게 프로토콜을 정의
protocol SomeProtocol {
		// 요구 사항을 정의
		let somethingg: Int = 0
    func doSomething()
}

// 이름 뒤에 콜론(:)으로 프로토콜들을 채택
struct SomeStructure: FirstProtocol, AnotherProtocol {
    // 요구 사항을 정의
		let somethingg: Int = 0
    func doSomething()
}

// 슈퍼클래스(상속해올 클래스)가 있고 클래스가 프로토콜을 채택할 때,
// 해당 슈퍼클래스 이름을 프로토콜 앞에 나열하고 쉼표로 구분
class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
    // 요구 사항을 정의
		let somethingg: Int = 0
    func doSomething()
}
```

### 요구사항

공식 문서의 설명 문구와 코드에 따르면, 요구 사항을 채택하는 형태(클래스, 구조체, 열거형)에게 어떤 동작이나 기능을 작성하여 사용할 ‘프로토콜’ 요구사항을 맞춘다 함

```swift
// MARK: - 프로퍼티 요구사항
protocol FullyNamed {
		// 그냥 'FullName'이라는 전체 이름을 제공할 수 있어야 한다 점만
		// (gettable 인스턴스 프로퍼티가 있어야함) 지정
    var fullName: String { get }
}

struct Person: FullyNamed { // 'Person'이라는 구조체는
		// 'FullyNamed' 프로토콜의 요구사항인 전체 이름을 제공할 수 있는 변수가 존재
    var fullName: String
}

let john = Person(fullName: "John Appleseed")
//john.fullName is "John Appleseed" 라 잘 출력

// MARK: - 함수 요구사항

/// 프로퍼티와 동일하게 프로토콜 정의의 일부로 작성됨
/// 중괄호나 메소드 내부의 정의가 존재 X.
/// 프로토콜 정의 내의 함수 매개변수에는 디폴트를 지정 X

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0

		// RandomNumberGenerator 프로토콜의 요구사항인 'random'이라는 메소드가 존재
		// 위 프로토콜 선언 부에 비어놓았던 random 메소드를 세부 기능은
		// 사용할 class나 구조체에서 요구사항에 맞춰 코딩
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)
            .truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}

// MARK: - Mutating
// struct와 enum 내에서 메서드를 정의하여 내부 프로퍼티를 변경할 때 사용하는 키워드
// 프로토콜에서 사용할 때는 일반 struct와 enum에서 사용하는 방식과 매우 비슷
// 공식문서에선 토클 스위치로 이를 설명함

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on

		// Togglable 프로토콜에 맟춰 세부 기능 코딩
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
```

### 그 외

- Delegation

  Delegation 말 그대로 ‘위임자’, 프로토콜를 공부해보면 틀만 설계해 놓고 사용자가 사용할 때 세부사항을 코딩하므로 즉 ‘너가 알아서 해라’ 라는 느낌이 강했음.

  Delegation 패턴은 주로 프로토콜(또는 인터페이스)을 사용하여 다른 객체에 어떤 기능을 위임하거나 대리 수행하도록 하는 디자인 패턴.(ex. UITableView, UICollectionView)

## 참고

[공식문서 - Protocol](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols)
