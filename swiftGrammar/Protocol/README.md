# Protocol

> Define requirements that conforming types must implement.

> 특정 작업이나 기능에 적합한 메서드, 프로퍼티 및 기타 요구 사항의 청사진을 정의함

`class`, `struct`, `enum` 이 이 프로토콜을 **"채택(conform)"** 해서 구현 가능

- 프로토콜의 요구 사항을 충족하는 모든 타입은 해당 프로토콜을 준수한다고 표현

- 프로토콜을 확장하여 이러한 요구 사항 중 일부를 구현하거나 준수하는 타입이 활용할 수 있는 추가 기능을 구현할 수 있음

*"이 타입은 반드시 이런 기능을 제공할 거야"* 라는 **계약(contract)** 같은 것

- **"약속된 규격"** 또는 **"인터페이스(interface)"** 개념


---

## Protocol Syntax

<details>
<summary> contents </summary>

```swift
protocol SomeProtocol {
    // protocol definition goes here
}
```

- 클래스, 구조체, 그리고 열거형과 유사한 방법으로 프로토콜을 정의합

```swift
struct SomeStructure: FirstProtocol, AnotherProtocol {
    // structure definition goes here
}
```

- 사용자 지정 유형은 특정 프로토콜을 채택함을 나타내기 위해 타입 이름 뒤에 프로토콜 이름을 콜론(`:`)으로 구분하여 정의

- 여러 프로토콜을 나열할 수 있으며, 각 프로토콜은 쉼표(`,`)로 구분

```swift
class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
    // class definition goes here
}
```

</details>

---

## Property Requirements

<details>
<summary> contents </summary>

> 프로토콜은 모든 준수 타입이 인스턴스 프로퍼티 또는 타입 프로퍼티에 특정 이름과 유형을 제공하도록 요구할 수 있음

> 프로토콜은 프로퍼티가 저장된 프로퍼티인지 연산 프로퍼티인지는 지정하지 않고, 필요한 프로퍼티 이름과 유형만 지정

> 또한 각 프로퍼티가 `gettable`인지, `gettable` 및 `settable` 인지도 지정이 필요

---

### gettable과 settable 인 프로퍼티를 요구할 경우

```swift
protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}
```

- 프로퍼티 요구사항은 항상 `var` 키워드와 함께 변수 프로퍼티로 선언

- `gettable` 과 `settable` 프로퍼티는 타입 선언 뒤에

    - `settable` 프로퍼티 **(읽기/쓰기)** : `{ get set }`
    
    - `gettable` 프로퍼티 **(읽기 전용)** : `{ get }`

    ---

```swift
struct MyStruct: SomeProtocol {
    var mustBeSettable: Int
    var doesNotNeedToBeSettable: Int {  // 읽기 전용은 계산 속성으로 구현
        return mustBeSettable * 2
    }
}
```

- 구현은 채택한 타입이 직접 해야 함

---

### 타입 프로퍼티 요구할 경우

```swift
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}
```

- 프로토콜에 정의할 때 `static` 키워드를 접두사로 둠

---

### 단일 인스턴스 프로퍼티 요구사항

> `FullyName` 프로토콜은 완벽한 이름을 제공하기 위해 준수하는 타입을 요구하는 ex

```swift
protocol FullyNamed {
    var fullName: String { get }
}
```

이 프로토콜은 다른 준수하는 타입을 지정하지 않으며 타입이 자체에 대한 전체 이름을 제공해야 된다고만 지정하고 프로토콜은 모든 `FullyNamed` 타입이 `String` 타입의 `fullName` 이라는 `gettable` 인스턴스 프로퍼티를 가져야함

1. `FullyNamed` 프로토콜은 채택하고 준수하는 `struct`

    ```swift
    struct Person: FullyNamed {
        var fullName: String
    }

    let john = Person(fullName: "John Appleseed")
    ```

    ---

2. `FullyNamed` 프로토콜을 채택하고 준수하는 더 복잡한 `class`

    ```swift
    class Starship: FullyNamed {
        var prefix: String?
        var name: String
        init(name: String, prefix: String? = nil) {
            self.name = name
            self.prefix = prefix
        }
        var fullName: String {
            return (prefix != nil ? prefix! + " " : "") + name
        }
    }
    var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
    // ncc1701.fullName is "USS Enterprise"
    ```

</details>

---

## Method Requirements

<details>
<summary> contents </summary>

> 프로토콜은 준수하는 타입에 의해 구현되기 위해 지정한 인스턴스 메서드와 타입 메서드를 요구할 수 있음

이 메서드는 일반적인 인스턴스와 타입 메서드와 같은 방식으로 명시적으로 프로토콜의 정의의 부분으로 작성되지만 중괄호(`{}`)가 없거나 메서드 본문이 없음

일반적인 메서드와 같은 규칙에 따라 가변 파라미터는 허용되지만 기본 값은 프로토콜의 정의 내에서 메서드 파라미터에 대해 지정될 수 없음

```swift
protocol SomeProtocol2 {
    static func someTypeMethod()
}
```

- 타입 프로퍼티 요구사항과 마찬가지로 프로토콜에 정의될 때 `static` 키워드를 항상 타입 메서드 요구사항 앞에 표기

- 클래스에 의해 구현될 때 타입 메서드 요구사항에 `class` 또는 `static` 키워드가 접두사로 붙는 경우에도 마찬가지

---

### 단일 인스턴스 메서드 요구사항을 가지는 프로토콜을 정의

> 아래의 예제는 단일 인스턴스 메서드 요구사항을 가지는 프로토콜을 정의하는 코드

```swift
protocol RandomNumberGenerator {
    func random() -> Double
}
```

`RandomNumberGenerator` 프로토콜은 호출될 때마다 `Double` 값을 반환하는 `random` 이라는 인스턴스 메서드를 가지는 모든 준수하는 타입을 요구

- `RandomNumberGenerator `프로토콜은 각 난수가 생성되는 방법에 대해 어떠한 것도 가정하지 않음

- 단순히 생성기가 새로운 난수를 생성하는 표준 방법을 제공하면 됩

```swift
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)
            .truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}
```

이 클래스는 `linear congruential generator` 로 알려진 의사 난수 `pseudorandom number` 생성기 알고리즘을 구현

```swift
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")

// "Here's a random number: 0.3746499199817101"
print("And another one: \(generator.random())")
// "And another one: 0.729023776863283"
```

</details>

---

## Mutating Method Requirements

<details>
<summary> contents </summary>

> 메서드가 속한 인스턴스를 **수정/변경** 해야하는 경우가 있는데,

> 값 타입 (구조체와 열거형)에 대한 인스턴스 메서드의 경우 메서드의 `func` 키워드 앞에 `mutating` 키워드를 위치시켜 메서드가 속한 인스턴스와 인스턴스의 모든 프로퍼티를 수정할 수 있음

프로토콜을 채택하는 모든 타입의 인스턴스를 변경하기 위한 프로토콜 인스턴스 메서드 요구사항을 정의하는 경우

프로토콜의 정의의 부분으로 `mutating` 키워드로 메서드를 표시함

이를 통해 구조체와 열거형이 프로토콜을 채택하고 메서드 요구사항을 충족할 수 있음


> `mutating` 으로 프로토콜 인스턴스 메서드 요구사항을 표시하면 클래스에 대한 해당 메서드의 구현을 작성할 때, `mutating` 키워드를 작성할 필요가 없음

> `mutating` 키워드는 구조체와 열거형에 의해서만 사용

---

###  단일 인스턴스 메서드 요구사항을 정의 ex

```swift
protocol Togglable {
    mutating func toggle()
}
```

- `toggle()` 메서드는 호출될 때 준수하는 인스턴스의 상태를 변경하기 위한 메서드를 나타내기 위해, `Togglable` 프로토콜 정의의 부분으로 `mutating` 키워드로 표시

```swift
enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
```

- `OnOffSwitch` 라는 열거형을 정의

- 열거형 `case` 인 `on` 과 `off` 를 나타내기 위해 2개의 상태를 변경

```swift
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
// lightSwitch is now equal to .on
```

</details>

---

## Initializer Requirements

<details>
<summary> contents </summary>

> 프로토콜은 준수하는 타입에 초기화 구문을 구현하도록 요구할 수 있음

```swift
protocol SomeProtocol3 {
    init(someParameter: Int)
}
```

초기화 구문을 작성하지만 중괄호(`{}`) 또는 초기화 구문 본문 없이 작성

---

### Class Implementations of Protocol Initializer Requirements(프로토콜 초기화 구문 요구사항의 클래스 구현)

```swift
class SomeClass: SomeProtocol3 {
    required init(someParameter: Int) {
        // initializer implementation goes here
    }
}
```

- `required` 키워드와 함께 초기화 구문 구현에 표시

- `required` 수식어를 사용하면 준수하는 클래스의 **모든 하위 클래스에 초기화 구문 요구사항의 명시적** 또는 **상속된 구현을 제공하여 프로토콜을 준수할 수 있음**

- *cf.* `final` *클래스는 하위 클래스가 될 수 없으므로* `final` *키워드로 표시된 클래스에* `required` *키워드를 프로토콜 초기화 구문 구현에 표시할 필요가 없음* 

```swift
protocol SomeProtocol4 {
    init()
}

class SomeSuperClass {
    init() {
        // initializer implementation goes here
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocol4 {
    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
        // initializer implementation goes here
    }
}
```

- 하위 클래스가 상위 클래스의 지정된 **초기화 구문을 재정의**

- 프로토콜로 부터 일치하는 초기화 구문 요구사항이 구현되면 `required` 와 `override` 키워드 둘 다 초기화 구문 구현에 표시함

---

### Failable Initializer Requirements(실패 가능한 초기화 구문 요구사항)

> 프로토콜은 **실패 가능한 초기화 구문 (Failable Initializers)** 에 정의 된대로 준수하는 타입에 대해 실패 가능한 초기화 구문 요구사항을 정의할 수 있음

- Failable Initializer(실패 가능한 초기화 구문) 요구사항은 준수하는 타입에 실패 가능하거나 실패 불가능한 초기화 구문에 의해 충족될 수 있음

- 실패 불가능한 초기화 구문 요구사항은 **실패 불가능한 초기화 구문** 또는 **implicitly unwrapped(암시적 언래핑)** 된 실패 가능한 초기화 구문에 의해 충족될 수 있음

---

</details>

## Protocols that Have Only Semantic Requirements(의미적 요구사항만 가지는 프로토콜)

<details>
<summary> contents </summary>

> 프로토콜 선언은 모든 요구사항이 포함되어야 하는 것은 아님

> 프로토콜은 의미적(semantic) 요구사항으로 사용할 수도 있음

Swift 표준 라이브러리는 필수 메서드나 프로퍼티를 가지지 않는 여러 프로토콜이 정의되어 있음

- `Sendable` : [동시성 도메인 간에 공유할 수 있는 값을 나타냄](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency#Sendable-Types)

- `Copyable` : [함수에 값을 전달할 때, Swift가 복사할 수 있는 값을 나타냄](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations#Borrowing-and-Consuming-Parameters)

- `BitwiseCopyable` : 비트 단위로 복사할 수 있는 값을 나타냄

- *ex*

    ```swift
    struct MyStruct2: Copyable {
        var counter = 12
    }

    extension MyStruct2: BitwiseCopyable { }
    ```

</details>

---

## Protocols as Types(타입으로써 프로토콜)

<details>
<summary> contents </summary>

> 프로토콜 자체는 어떤 기능도 구현하지 않습니다. 이런점과 상관없이 코드에서 타입으로 프로토콜을 사용할 수 있음

프로토콜은 **"규약"** 이지 **구현** 이 아님

- `class`나 `struct`, `enum`은 기능(메서드, 프로퍼티 등)을 실제로 구현 가능

- 프로토콜은 어떤 기능이 있어야 한다는 **"규약"** 만 정의

- Swift에서는 프로토콜 자체를 타입처럼 사용 가능

프로토콜을 타입처럼 사용하는 세 가지 방식이 존재

---

### Generics(제네릭) 제약조건으로 프로토콜 사용


- 제네릭 함수나 타입을 정의할 때, **"이 제네릭은 반드시 특정 프로토콜을 따른 타입이어야 한다"** 라고 제약을 걸 수 있음

- 그러면 그 함수는 프로토콜을 준수하는 어떤 타입이든 받아서 동작할 수 있음

- *ex*

    ```swift
    protocol Drawable {
        func draw()
    }

    func render<T: Drawable>(_ item: T) {
        item.draw()
    }
    ```

    - 호출자는 `Drawable` 을 준수하는 타입을 넘길 수 있고, 함수는 제네릭하게 동작

---

### 불투명한 타입 (Opaque Type)

- `some Protocol` 문법을 쓰는 경우

- 함수가 반환값의 **"구체적인 타입"** 은 숨기고, **"이 타입이 특정 프로토콜을 따른다"** 라는 사실만 노출함

- 즉, API를 쓰는 사람은 정확히 어떤 타입인지 알 수 없지만, 최소한 그 프로토콜에 정의된 기능은 쓸 수 있음

- *ex*

    ```swift
    // 프로토콜을 따르는 구체 타입
    struct Circle: Drawable {
        func draw() {
            print("그려그려그려 원을~")
        }
    }

    //  불투명 타입 (Opaque Type) 사용
    func makeShape() -> some Drawable {
        return Circle()
    }
    ```

---

### 박스형 프로토콜 타입 (Existential Types)

- 그냥 프로토콜을 타입처럼 직접 쓰는 방식

   - ex: `var shape: Drawable`

- 여기서는 구체적인 타입(`Circle`, `Square` 등)은 런타임 시점에 결정

- Swift는 이걸 가능하게 하기 위해 내부적으로 **"박스(Box)"** 라는 간접 계층을 둠

- 그 결과 런타임 유연성은 얻지만, 성능 비용이 생기고, 또 **"프로토콜에 정의된 멤버"** 까지만 접근할 수 있음

- *ex*

    ```swift
    // 프로토콜을 따르는 구체 타입
    struct Circle: Drawable {
        func draw() {
            print("그려그려그려 원을~")
        }
    }

    struct Square: Drawable {
        func draw() {
            print("그려그려그려 사각형을~")
        }
    }

    // 박스형 프로토콜 타입 (Existential Type) 사용
    func testExistential() {
        var shape: Drawable = Circle()  // Circle을 할당
        shape.draw()
    
        shape = Square()  // 런타임 시점에 다른 타입으로 교체 가능
        shape.draw()
    }
    ```

</details>


---

## 참고

- [공식문서 - Protocol](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols)

- [블로그 참고 - Protocol 이해하기 (1/6) - Protocol이 도대체 뭔가요?(개발자소들이)](https://babbab2.tistory.com/174)

- [gitBook 참고 - Protocol](https://bbiguduk.gitbook.io/swift/language-guide-1/protocols)