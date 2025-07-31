# Unowned References and Implicitly Unwrapped Optional Properties

> 서로가(프로퍼티가) 반드시 존재해야 하는 관계일 때, **강한 참조 순환** 은 피하고 싶을 때 어떻게 할까

- `unowned` 참조

- `!` 로 선언하는 **프로퍼티(암시적 추출 옵셔널)** 를 함께 쓰는 패턴

| 용어                                      | 뜻                                                  |
| --------------------------------------- | -------------------------------------------------- |
| **unowned**                             | 참조 카운트 증가 X, 참조는 유지. 참조 대상이 없어지면 메모리 접근 오류 (crash) |
| **Implicitly Unwrapped Optional (`!`)** | 초기에는 `nil`일 수 있지만, 사용 시점에는 **무조건 값이 있다고 가정**하는 옵셔널   |

---

## 기본 전제: 세 가지 상황

1. 서로 **옵셔널** 관계, `Person` <-> `Apartment` `weak` 사용

2. 한 쪽만 **옵셔널** `Customer` -> `CreditCard` `unowned` 사용

3. 서로 반드시 존재	`Country` <-> `City` `unowned` + **암시적 추출 옵셔널(`!`)** 사용

---

## 1. 약한(`weak`) 참조 를 사용해야는 case

```swift
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}
```

- `Person` 과 `Apartment` ex는 두 프로퍼티 모두 `nil` 이 허용되어 **강한 참조 순환** 을 유발할 가능성이 있는 상황 


```swift
var john: Person?
var unit4A: Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john
```

- 이 case에는 **약한 참조** 를 사용하는 것이 가장 좋음

---

## 3. 미소유(`unowned`) 참조 를 사용해야는 case

```swift
class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}
```

- `City` 의 `init` 는 `Country`의 `init` 내에서 호출

- `Country` 의 `init` 는 새 `Country` 인스턴스가 완전히 초기화될 때까지 `City` `init`에 `self` 를 전달할 수 없음

- 이러한 요구 사항을 충족하기 위해 `Country` 의 `capitalCity` 프로퍼티를 **암시적으로 언래핑** 된 **옵셔널** 으로 선언

    - `capitalCity` 속성은 다른 옵셔널과 마찬가지로 기본값 `nil` 을 가지지만,
    
    - **암시적으로 언래핑된 옵셔널** 에서 설명한 대로 값을 언래핑하지 않고도 접근할 수 있음

    ---

- `capitalCity` 는 기본 `nil` 값을 가지므로, `Country` 인스턴스가 `init` 내에서 `name` 프로퍼티를 설정하는 즉시 새 `Country` 인스턴스가 완전히 초기화된 것으로 간주

    - `Country` `init` 는 `name` 이 설정되는 즉시 **암시적** `self` 프로퍼티를 **참조하고 전달할 수 있음**

    ---

- 이 모든 것은 **강한 참조 순환** 을 생성하지 않고도 단일 명령문에서 `Country` 및 `City` 인스턴스를 생성할 수 있음

    - 옵셔널 값을 풀기 위해 `!` 를 사용할 필요 없이 `capitalCity` 에 직접 액세스할 수 있음을 의미

    ---

```swift
var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")
// "Canada's capital city is called Ottawa"
```

- 언래핑된 옵셔널을 사용하면 클래스 초기화 요구 사항이 모두 충족

- 초기화가 완료되면 `capitalCity` 은 **옵셔널이 아닌 값처럼 사용하고 접근할 수 있으며** , 동시에 **강한 참조 순환** 을 피할 수 있음

---

## 원본

- [공식문서 - Unowned References and Implicitly Unwrapped Optional Properties](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/#Unowned-References-and-Implicitly-Unwrapped-Optional-Properties)