# ARC(Automatic Reference Counting)

> Swift는 ARC(Automatic Reference Counting)를 사용하여 앱의 메모리 사용량을 추적하고 관리
> ARC는 해당 인스턴스가 더 이상 필요하지 않을 때 클래스 인스턴스에서 사용하는 메모리를 자동으로 해제
> Swift에서 ARC를 사용하는 것은 Objective-C에서 ARC를 사용하기 위한 ARC 릴리스 정보로 전환에 설명된 접근 방식과 매우 유사
> 참조 횟수는 클래스의 인스턴스에만 적용 됨. 구조 및 열거형은 참조 유형이 아닌 값 유형이며 참조로 저장 및 전달되지 안흥ㅁ

Swift(UIKit 환경)에선 주로 메모리 구조 중 힙(Heap)을 주로 다루게 됨
<br/>

ARC가 메모리 영역 중 힙 영역을 관리하게 됌
<br/>

## ARC를 왜 쓸까

swift에서는 클래스의 새 인스턴스를 만들 때마다 ARC는 해당 인스턴스에 대한 정보를 저장하기 위해 메모리를 할당함

인스턴스를 더 이상 필요하지 않으면 ARC는 해당 인스턴스에서 사용하는 메모리를 해제하여 메모리를 다른 용도로 대신 사용 가능

이렇게 하면 클래스 인스턴스가 더 이상 필요하지 않을 때 메모리 공간을 차지하지 X -> **메모리 해제**

즉 코드를 작성하는 과정에서 직접 힙에 대한 것을 하지 않아도 알아서 힙에서 할당되고 있었다는 것

**_그러나 ARC가 아직 사용 중인 인스턴스의 할당을 해제하면 더 이상 해당 인스턴스의 속성에 액세스하거나 해당 인스턴스의 메서드를 호출이 불가능_**

실제로 인스턴스에 액세스하려고 하면 App이 충돌할 가능성이 커지는 문제가 생김

> 인스턴스가 여전히 필요한 동안 사라지지 않도록 ARC는 현재 각 클래스 인스턴스를 참조하는 속성, 상수 및 변수의 수를 추적
> ARC는 해당 인스턴스에 대한 활성 참조가 하나 이상 존재하는 한 인스턴스 할당을 취소 X

그렇기 때문에 ARC를 다룰 줄 알아야함

## Automatic Reference Counting 작동과 Heap

```swift
// name이라는 저장된 constant property 정의하는 Person이라는 간단한 클래스로 시작
class Person {
    let name: String

    // MARK: - 1. initializer
    init(name: String) {
        self.name = name
        // 초기화를 나타내는 부분
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

// 선택적 유형이므로 자동으로 nil 값으로 초기화되며 현재 Person 인스턴스를 참조 X
var reference1: Person?

// MARK: -2.
// referencel 는 스택영역에 할당
// Person은 힙영역에 할당
reference1 = Person(name: "John Appleseed") // John Appleseed is being initialized
```

Person 클래스의 이니셜라이저를 호출하는 지점에 "John Appleseed is being initialized"라는 메시지가 출력됨

새 Person 인스턴스가 reference1 변수에 할당되었으므로 이제 reference1에서 새 Person 인스턴스에 Strong 참조가 생김

적어도 하나의 강력한 참조가 있기 때문에 ARC는 이 Person이 메모리에 유지되고 할당이 취소되지 않게 되는 것

```swift
let cloneRef = reference1
```

인스턴스가 복사되는 것이 아닌 같은 힙 영역을 가르키는 것, 또한 힙 영역 특성상 메모리 해제가 필요한 데 이를 ARC가 해줌
<br/>

> 적어도 하나의 Strong 참조가 있기 때문에

**_즉 reference1, cloneRef이 같은 메모리를 참조_**

## RC

> 힙 영역의 메모리를 관리하는 방법은 GC와 RC가 존재

- 참조 계산 시점

  - 컴파일 시점에 언제 참조되고 해제되는지 결정되어 런타임 때 그대로 실행

- 장점

  - 개발자가 참조 해제 시점을 파악할 수 있음
  - RunTime 시점에 추가 리소스가 발생하지 않음

- 단점
  - 순환 참조가 발생 시 영구적으로 메모리가 해제되지 않을 수 있음

```swift
reference1 = nil
reference2 = nil
```

두 개의 변수에 nil을 할당하여 이러한 두 개의 강한 참조(원래 참조 포함)를 중단하면 하나의 강한 참조가 유지되고 Person 인스턴스가 할당 해제되지 않음

```swift
reference3 = nil // "John Appleseed is being deinitialized"
```

ARC는 세 번째이자 마지막 강한 참조가 끊어질 때까지 Person 인스턴스를 할당 해제 X

이 시점에서 Person 인스턴스를 더 이상 사용하지 않는다는 것이 분명해짐

## 참고

[공식문서 - ARC-in-Action](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/)

[블로그 참조](https://babbab2.tistory.com/26)
