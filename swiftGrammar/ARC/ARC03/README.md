# Weak References

> 약한 참조는 참조하는 인스턴스를 강력하게 유지하지 않는 참조

- **ARC** 가 참조된 인스턴스를 삭제하는 것을 막지 않음

- 참조가 강한 참조 순환에 포함되는 것을 방지

- 프로퍼티 or 변수 선언 앞에 `weak` 키워드를 배치하여 **약한 참조** 를 표현

## Weak References 특징


- 인스턴스를 참조할 시, **RC를 증가 X**

- 참조하던 인스턴스가 메모리에서 해제된 경우, **자동으로 nil이 할당되어 메모리가 해제**

    - **약한 참조** 는 자신이 참조하는 인스턴스를 **강한 참조** 로 유지하지 않기 때문에
    
    - **약한 참조** 가 여전히 참조하는 동안 해당 인스턴스가 **할당 해제** 가 가능

    - **ARC** 는 참조하는 인스턴스가 할당 해제될 때 자동으로 **약한 참조**를 `nil`로 설정

    ---

- **weak는 무조건 옵셔널 타입의 변수**

    - **약한 참조** 는 런타임 시 값이 `nil`로 변경될 수 있도록 허용해야 함
    
    - 항상 **옵셔널 변수** 로 선언

---

## 약한 참조(Weak Refernces) 동작 과정

```swift
class Person {
    let name: String

    init(name: String) {
        self.name = name
    }

    var apartment: Apartment?

    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    let unit: String
    init(unit: String) {
        self.unit = unit
    }

    weak var tenant: Person? // 2

    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

// 1
var john: Person?
var unit4A: Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john
```

1. `john` 및 `unit4A` 선언 시, 강한 참조와 두 인스턴스 간의 링크는 이전과 같이 생성

2. `john` (`Person`) 인스턴스에는 여전히 `Apartment` 인스턴스에 대한 **강한 참조** 존재하지만 `unit4A` (`Apartment`) 인스턴스에는 `Person` 인스턴스에 대한 **약한 참조** 가 존재

    ```swift
    class Apartment {
        // ...

        weak var tenant: Person?

        // ...
    }
    ```

    <p align="center">
        <img src="https://docs.swift.org/swift-book/images/org.swift.tspl/weakReference01@2x.png" alt="Example Image" width="80%">
    </p>

    ---

3. `john`를 `nil`로 설정하여 **강한 참조** 를 해제하면 `Person` 인스턴스에 대한 **강한 참조**가 존재 X

    ```swift
    john = nil // "John Appleseed is being deinitialized"
    ```
    
    ---

4. `Person` 인스턴스에 대한 강한 참조가 더 이상 없기 때문에 할당이 취소되고 `tenant` 프로포티가 `nil` 로 설정되는 것

    <p align="center">
        <img src="https://docs.swift.org/swift-book/images/org.swift.tspl/weakReference02@2x.png" alt="Example Image" width="80%">
    </p>

    `Apartment` 인스턴스에 대한 **강한 참조** 설정

    ---


5. `unit4A` 에서 **강한 참조** 를 해제하면 `Apartment` 인스턴스에 대한 **강한 참조** 는 더 이상 존재하지 않음

    ```swift
    unit4A = nil // "Apartment 4A is being deinitialized"
    ```

    <p align="center">
        <img src="https://docs.swift.org/swift-book/images/org.swift.tspl/weakReference03@2x.png" alt="Example Image" width="80%">
    </p>

---

## 참고

[공식문서 - Weak-References](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/#Weak-References)
