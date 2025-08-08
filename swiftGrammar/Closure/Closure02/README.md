# `@autoclosure`

> An autoclosure is a closure that’s automatically created to wrap an expression that’s being passed as an argument to a function.

**"표현식"** 을 자동으로 **"클로저"** 로 감싸주는 문법

- 일반적인 **Closure**

  ```swift
  // 일반적인 Closure
  func funcA(_ closure: () -> Void) {
      closure()
  }

  funcA({ print("Hello Closure") }) // Hello Closure
  ```
  ---

- `@autoclosure`

  ```swift
  func funcA(_ closure: @autoclosure () -> Void) {
    closure()
  }

  funcA(print("Hello Closure"))
  ```

  ---

- 대표적으로 [assert(condition:message:file:line:)](<https://developer.apple.com/documentation/swift/assert(_:_:file:line:)>) 함수가 예

  ```swift
  func assert(
      _ condition: @autoclosure () -> Bool,
      _ message: @autoclosure () -> String = String(),
      file: StaticString = #file,
      line: UInt = #line
  )
  ```

---

## 사용 이유

평가(실행)를 지연시키고 싶을 때 유용

- ex: *함수에 넘긴 표현식을 지금 바로 실행하지 않고, 나중에 필요할 때 실행하고 싶을 때*

- 성능 최적화, 부작용 방지 등에 자주 사용

```swift
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// 5

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// 5

print("Now serving \(customerProvider())!")
// Now serving Chris!

print(customersInLine.count)
// 4
```

```swift
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

let customerProvider = { customersInLine.remove(at: 0) } // 1
```

1. `customerProvider` : 클로저

   - `remove(at: 0)` 는 배열에서 첫 요소를 제거하는 부작용 있는 코드이지만

   - `{ customersInLine.remove(at: 0) }` 로 감쌌기 때문에 실행이 지연

   ---

```swift
print(customerProvider()) // 2
```

2. 여기서 실제로 실행됨

---


## 일반 클로저를 함수에 전달하는 경우

```swift
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}

serve(customer: { customersInLine.remove(at: 0) })
```

- 클로저를 명시적으로 `serve()` 에 넘김

- 이 방식은 명확하지만 `{}` 괄호가 필요

---

## `@autoclosure` 로 간결하게 쓰기

```swift
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}

serve(customer: customersInLine.remove(at: 0))
```

- `customersInLine.remove(at: 0)` 를 자동으로 클로저로 감쌌기 때문에

```swift
serve(customer: { customersInLine.remove(at: 0) })
```

- 내부적으로는 이렇게 처리되는 것

---

## `@autoclosure` + `@escaping`

```swift
class CustomerManager {
    private(set) var customerProviders: [() -> String] = []

    func collect(_ provider: @autoclosure @escaping () -> String) {
        customerProviders.append(provider)
    } // collect

    func serveAll() {
        print("Collected \(customerProviders.count) closures.")
        for provider in customerProviders {
            print("Now serving \(provider())!")
        }
    } // serveAll
}
```

- `collect(_:)` 함수는 `provider` 인수로 전달된 클로저를 호출하는 대신,  클로저를 `customerProviders` 배열에 추가

- 이 배열은 함수 범위 밖에서 선언되었으므로, 배열에 있는 클로저는 함수가 반환된 후에 실행될 수 있음

- 따라서 `provider` 인수의 값은 함수 범위를 벗어날 수 있어야 함

---

## 참고

[공식문서 - Autoclosures](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/#Autoclosures)

[공식문서 - assert](<https://developer.apple.com/documentation/swift/assert(_:_:file:line:)>)

[블로그 참조](https://babbab2.tistory.com/81)
