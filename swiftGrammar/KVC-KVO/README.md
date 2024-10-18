# KVC, KVO

> 객체의 프로퍼티에 간접적으로 접근하거나, 변화를 감지할 수 있는 기능을 제공

## KVC(Key-Value Coding)

> 객체의 프로퍼티에 대해 key를 통해 간접적으로 접근할 수 있게 해주는 메커니즘

- 일반적으로 객체의 프로퍼티에 대해 접근할 경우 직접 접근하는 방식이 아닌 간접적으로 접근을 해서 Value를 설정 및 가져올 수 있는 방식

  - 객체의 프로퍼티 값을 얻거나 수정할 경우, 객체에서 정의한 **getter**, **setter** 을 통해 접근

  - _Objective-C_ 와 _Swift_ 는 **Key-Value Coding** 을 통해 간접적으로 접근 함
    <br/>

- Objective-C 런타임에 의존하므로 프로퍼티 앞에 **@objc 어노테이션** 을 붙여서 사용
  <br/>

## KVC 특징

- **동적 접근**
  프로퍼티에 직접 접근하지 않고 문자열로 정의된 키를 사용하여 값에 접근
  <br/>

- **유연성**
  - 리플렉션(reflection)을 사용하여 런타임에 프로퍼티를 다룸
  - 일반적으로 접근할 수 없는 private 프로퍼티에도 접근 가능
    <br/>

## 예시

```swift
class Person: NSObject {
    @objc var name: String?
}
```

NSObject를 서브클래싱하고 @objc를 붙인 모델 정의

```swift
let person = Person()

print(person.name)

person.setValue("B0X", forKey: "name")

let name = person.value(forKey: "name")
print(name)
// Optional(B0X)
```

<br/>

## KVO (Key-Value Observing)

> 객체의 특정 프로퍼티가 변경될 때, 이를 관찰하고 반응할 수 있도록 해주는 메커니즘

- 사용하면 객체의 속성에 변화가 발생할 때 자동으로 notification
  <br/>

- 객체의 프로퍼티의 변경사항을 다른 객체에 알리기 위해 사용하는 코코아 프로그래밍 패턴

  - KVC와 비슷하게 key값을 가지고 프로퍼티에 접근하는데. **Key-Value Observing** 을 통해 **observing**

  - NSObjec를 상속한 클래스에서만 KVO를 사용
    <br/>

- Model과 View처럼 논리적으로 분리된 파트간의 변경사항을 전달하는데 유용
  <br/>

## KVO 특징

- **자동 관찰**
  객체의 속성이 변경될 때 이를 자동으로 감지
  <br/>

- **간단한 구현**
  특정 속성의 변화를 간단히 관찰할 수 있어 이벤트 기반 처리에 유용
  <br/>

- **관찰 대상 속성의 변경사항을 추적**
  _willChangeValue(forKey:)_ 와 _didChangeValue(forKey:)_ 를 사용해 변화를 수동으로 관리 가능
  <br/>

## 예시

```swift
class Human: NSObject {
    @objc dynamic var name: String?
}
```

프로퍼티 키워드에 **@objc dynamic** 을 붙여서 사용

```swift
let human = Human()

human.observe(\.name, options: [.old, .new]) { instance, change in
  print(change.oldValue, change.newValue)
  // Optional(nil) Optional(Optional("BOX"))
}

human.name = "B0X"
print(human.name)
// Optional("B0X")
```

name이 변경될때마다 특정 작업을 수행하기 위해서 name을 observing하려면, observe(\_:options:changeHandler)를 정의
<br/>

## KVO와 willSet, didSet의 차이

- KVO는 특정한 프로퍼티의 변화를 런타임에 동적으로 관찰하며, 해당 프로퍼티의 변화를 감지하고 반응
  보통 UIKit 및 Objective-C와의 상호작용에서 사용
  <br/>

- willSet, didSet은 Swift의 프로퍼티 옵저버로, 프로퍼티의 값을 설정할 때 자동으로 호출
  이 옵저버는 KVO와 달리 외부에서 관찰할 수 없으며, 해당 클래스 내부에서만 동작
  <br/>

## 참고

- [공식문서 - About Key-Value Coding](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107-SW1)

- [공식문서 - Using Key-Value Observing in Swift](https://developer.apple.com/documentation/swift/using-key-value-observing-in-swift)

- [블로그 참조 - zeddios(Key-Value Coding(KVC))](https://zeddios.tistory.com/1218?category=685736)

- [블로그 참조 - zeddios(Key-Value Observing(KVO) in Swift)](https://zeddios.tistory.com/1220)

- [블로그 참조 - dongminyoon([SWIFT] KVC (Key - Value - Coding))](https://dongminyoon.tistory.com/69)

- [블로그 참조 - 김종권iOS(KVC (Key Value Coding), KVO (Key Value Observing), value(forKey:), setValue(\_:forKey:) 개념)](https://ios-development.tistory.com/984)
