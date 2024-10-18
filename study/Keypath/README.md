# Keypath

> 프로퍼티에 대한 경로를 나타내며, 컴파일 타임에 타입 검사를 통해 안전하게 사용

> KeyPath는 프로퍼티의 경로를 추적할 수 있고, 이를 통해 프로퍼티 값에 접근하거나 변경을 감지

- **Read 전용 KeyPath**
  값을 조회하는 데 사용
  <br/>

- **Write 가능한 KeyPath**
  값을 설정하는 데 사용됩
  <br/>

## 예시

```swift
class Person {
    var name: String = "B0X"
}

let person = Person()
let nameKeyPath = \Person.name

// KeyPath Read
print(person[keyPath: nameKeyPath])
// B0X

// KeyPath Write
person[keyPath: nameKeyPath] = "BOLT"
print(person.name)
// BOLT
```

## 참고

- [블로그 참조 - zeddios(Key-Value Coding(KVC))](https://zeddios.tistory.com/1218?category=685736)

- [블로그 참조 - zeddios(Key-Value Observing(KVO) in Swift)](https://zeddios.tistory.com/1220)
