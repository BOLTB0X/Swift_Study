# propery Overriding

- 부모 클래스의 저장 프로퍼티나 계산 프로퍼티를 하위 클래스에서 재정의하는 것

## Stored Property

- 서브 클래스에서는 상속된 프로퍼티의 특성이 Stored(저장) property인지, 연산 property 인지 구분이 불가능

<br/>

- 그냥 상속받은 property의 이름과 타입정도 read 가능
  <br/>

cf. 변경 가능한 프로퍼티를 read-only 프로퍼티로 오버라이딩 할 수 없음

- 예시

  ```swift
  class Coder: Human {
      var filed = “iOS"

      override var name: String {
          get {
              return self.filed
          }
          set {
              self.field = newValue
          }
      }
  }
  ```

## Computed Property

- 상위 클래스에서 정의된 연산 프로퍼티의 getter와 setter를 하위 클래스에서 재정의(override)
  <br/>

- getter/setter 예시 (1)
  ```swift
  class anotherCoder: Human {
      override var feild: String {
          get {
              return self.name + " android"
          }
          set {
              self.name = newValue
          }
      }
  }
  ```

<br/>

- getter/setter 예시 (2)

  ```swift
  class Human {
      var name = "3kh"

      var alias: String {
          get {
              return self.name + " B0X"
          }
          set {
              self.name = newValue
          }
      }
  }
  // Human이란 클래스에 alias라는 연산 프로퍼티가 getter / setter로 구현된 경우

  class Coder: Human {
      override var alias: String {  // 해당 프로퍼티 오버라이딩 불가능
         return self.name + " !?"
      }
  }
  ```

<br/>

- Read-Only 연산 프로퍼티 오버라이딩 예시

  ```swift
  class Human {
      var name = "lkh"

      var nick: String {
          return self.name + " B0X"
      }
  }

  class coder: Human {
      override var feild: String {
          return self.name + " iOS”
      }
  }
  ```

## Property Observers

- willSet과 didSet로 Override 가능
  <br/>

- 부모클래스에 정의한 프로퍼티가 **Computed Property**/**Stored Property**인지는 상관 X
  <br/>

- **Constant Stored Property**나 **Read-Only Computed Property**는 **Property Observer Override** 불가능
  <br/>

- 부모 클래스에서 정의된 프로퍼티에 대해 변경 감지 로직을 추가 가능
  <br/>

- Property Observers 예시

  ```swift
  class Animal {
      var age: Int = 0
  }

  class Dog: Animal {
      override var age: Int {
          willSet {
              print("개 나이는 \(newValue)살 로 설정.")
          }
          didSet {
              print("개는 지금 \(age)살.")
          }
      }
  }

  let myDog = Dog()
  myDog.age = 31
  // 개 나이는 0살 로 설정.
  // 개는 지금 31살.
  ```

## 참조

- [블로그 참조 - 개발자 소들이(상속1)](https://babbab2.tistory.com/125)

- [블로그 참조 - 개발자 소들이(상속2)](https://babbab2.tistory.com/126)

- [블로그 참조 - VincentGeranium Blog(상속)](https://vincentgeranium.github.io/ios,/swift/2020/05/12/basicSyntax-1.html)
