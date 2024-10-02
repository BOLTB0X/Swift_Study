# Inheritance

> Subclass to add or override functionality.

- A 객체가 B 객체를 상속받아 B 객체의 요소(property)를 사용하는 것
  <br/>

- A 객체는 자식, B 객체 부모
  <br/>

- 자식 객체는 상속된 부모 객체의 은닉화되어진 구성에 따라 변수, 메소드에 접근 가능
  <br/>

## Base Class

```swift
class Human {
    var field: String?
    var age: Int?
}
```

- Human 이란 클래스 명 뒤에 아무것도 없는 클래스
  <br/>

- 아무런 상속 받지 않음
  <br/>

- cf. 뒤에 ‘Hashable’같은 프로토콜을 채택해도 base class에 속함
  <br/>

## Subclassing

> Subclassing is the act of basing a new class on an existing class

```swift
class Coder: Human { // class Human의 속한 프로퍼티들도 싹다 사용 가능
	var noteBook: String?
}

let lkh: Coder = .init()
Lkh.field
Lkh.noteBook
```

- 기본 클래스를 기반으로 새로운 클래스를 만드는 것
  <br/>

- 서브 클래스 이름 옆에 콜론(:)을 쓰고 가장 먼저 상속 받고자 하는 슈퍼 클래스의 이름 추가
  <br/>

- 상위 클래스인 Human = Super class, human을 상속받는 lkh 클래스를 sub class
  <br/>

- 메소드도 상속 가능~
  <br/>

## final

> Inheritance 금지

```swift
final class Human {
    var field: String?
    var age: Int?
}
```

  <br/>

## Overriding

> 상속할 인스턴스 메서드, 타입 메서드, 인스턴스 프로퍼티, 타입 프로포티, 서브스크립트을 상속할 것 기반으로 구현 및 수정하는 것이 Overriding

상위 클래스 또는 부모 클래스에서 정의된 메서드, 프로퍼티, 또는 서브스크립트를 하위 클래스에서 재정의(덮어씌우는)

- Method Overriding

  - **override** 키워드를 반드시 사용해야 하며, 부모 클래스의 원래 구현을 **super** 키워드를 통해 참조 가능

        ```swift
        class Coder: Human {
        override func description() {

    print(“iOS입니다”)
    }
    }
    ```
    <br/>

  - Coder 클래스는 Human 슈퍼클래스의 description 메소드를 오버라이딩(재정의)
    <br/>

  - coder 인스턴스를 만들고 coder의 description을 실행하면 오버라이딩한게 되는 것
    <br/>

  - Cf. 만약 슈퍼클래스의 메소드를 이용하고 싶으면?

    ```swift
    class Coder: Human {
      override func description() {
    	     print(“iOS입니다”)
     }
      super.description() // super의 메소드 명시해줌
    }
    ```

    <br/>

  - [Property Overriding]()

## 참조

- [공식문서 - inheritance](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/inheritance/)

- [블로그 참조 - 개발자 소들이(상속1)](https://babbab2.tistory.com/125)

- [블로그 참조 - 개발자 소들이(상속2)](https://babbab2.tistory.com/126)
