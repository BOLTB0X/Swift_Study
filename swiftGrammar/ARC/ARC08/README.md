# Resolving Strong Reference Cycles for Closures

클로저가 `self`를 캡처하면서 생기는 **강한 순환 참조** 해결 방법은 **Capture List**

---

## 강한 참조 순환(Strong Reference Cycle) 문제


- 클로저가 클래스 인스턴스를 강하게 참조하고, 그 인스턴스가 그 클로저를 프로퍼티로 가지고 있을 경우

- 서로를 **강한 참조** 해서 메모리에서 해제되지 않는 상황이 생김 (**순환 참조**)

```swift
lazy var asHTML: () -> String = {
    return "<\(self.name)>\(self.text ?? "")</\(self.name)>"
}
```

-  `asHTML` 클로저는 `self` 를 **캡처** 해버려서 `HTMLElement` 인스턴스를 계속 붙잡고 있게 되는 것

해결책은 **캡처 리스트** 로 `self` 를 약하게 참조

---

## Defining a Capture List

```swift
lazy var someClosure = {
        [unowned self, weak delegate = self.delegate]
        (index: Int, stringToProcess: String) -> String in
    // closure body goes here
}
```

- **Capture List** 의 각 항목은 `weak` 또는 `unowned` 키워드와 클래스 인스턴스 참조(ex: `self`)

- 특정 값으로 초기화된 변수(ex: `delegate = self.delegate` )의 쌍, 이러한 쌍은 대괄호 안에 쉼표로 구분하여 작성

- 클로저의 매개변수 목록과 반환 타입이 제공된 경우 해당 목록 앞에 배치

```swift
lazy var someClosure = {
        [unowned self, weak delegate = self.delegate] in
    // closure body goes here
}
```

- 클로저가 컨텍스트에서 추론될 수 있기 때문에 매개변수 목록이나 반환 타입을 지정하지 않는 경우 **Capture List** 를 클로저의 맨 처음에 배치하고 그 뒤에 `in` 키워드 를 붙임

---

## Weak and Unowned References

| 타입          | weak             | unowned                             |
| ----------- | ---------------- | ----------------------------------- |
| 메모리에서 해제되면? | 자동으로 `nil` 됨     | 여전히 존재한다고 가정함 (해제된 인스턴스 접근 시 crash) |
| 타입          | **옵셔널**          | **비옵셔널**                            |
| 사용 시기       | 참조 대상이 사라질 수 있음  | 참조 대상이 자신보다 오래 살아있거나 동시에 해제됨        |
| 안전성         | 더 안전 (`nil` 체크 가능) | 더 위험 (`nil` 아님을 보장해야 함)               |

---

### `unowned`

**`self` 가 항상 살아있다고 보장 -> `unowned`**

```swift
lazy var asHTML: () -> String = {
        [unowned self] in
    if let text = self.text {
        return "<\(self.name)>\(text)</\(self.name)>"
    } else {
        return "<\(self.name) />"
    }
}
```

- `HTMLElement` 인스턴스와 `asHTML` 클로저는 **함께 생성되고, 함께 해제됨**

- 그렇기 때문에 **강한 참조 순환 없이** `self` 를 참조 가능

```swift
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
```

1. `HTMLElement` 인스턴스 생성

2. `asHTML` 클로저가 `lazy` 로 초기화(필요할 때 생성)

3. 클로저 내부에서 `self` 를 `unowned`로 캡처함

4. 클로저는 `self` 를 **강하게 참조하지 않음, 순환 참조 없음**

5. `HTMLElement` 인스턴스를 `nil` 로 설정하면 `deinit` 호출, 해제됨

---

### weak

`self` 가 클로저보다 먼저 해제될 수 있는 경우 -> `weak`

```swift
lazy var asHTML: () -> String = { [weak self] in
    guard let self = self else {
        return "<unknown />"
    }

    if let text = self.text {
        return "<\(self.name)>\(text)</\(self.name)>"
    } else {
        return "<\(self.name) />"
    }
}
```

- `self` 는 옵셔널이 되기 때문에 안전하게 `nil` 체크

```swift
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML()) // <p>hello, world</p>

paragraph = nil
```

- **옵셔널 바인딩** 꼭 사용

---

## 원본

- [공식문서 - Resolving Strong Reference Cycles for Closures](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/#Resolving-Strong-Reference-Cycles-for-Closures)