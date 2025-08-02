# Strong Reference Cycles for Closures

> 클로저 안에서 `self`를 참조하면, 인스턴스와 클로저 사이에 **강한 참조 순환** 이 생길 수 있음

> 그러면 인스턴스가 메모리에서 해제되지 않고 계속 남음 **(메모리 누수)**

이를 해결하려면 **[캡처 리스트(capture list)]** 를 사용해야 함

## Intro : 클로저도 강한 순환 참조를 만듬

```swift
class HTMLElement {

    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}
```

- `HTMLElement` 클래스는 요소의 이름을 나타내는 `name` 프로퍼티를 정의

- 이 두 가지 간단한 프로퍼티 외에도 `HTMLElement` 클래스는 `asHTML` 이라는 `lazy` 프로퍼티 를 정의

- 이 프로퍼티는 `name` 과 `text` 를 결합하여 HTML 문자열 조각으로 만드는 클로저를 참조

- `asHTML` 프로퍼티는 `() -> String` , 즉 *"매개변수를 받지 않고 문자열 값을 반환하는 함수"*

    ```swift
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    ```
    
    -  `asHTML` 클로저는 `self.name` 과 `self.text` 를 **참조** 함

    - 인스턴스가 클로저를 **소유** 하고 있고
클로저는 다시 인스턴스를 **캡처** 해서 참조하고 있음

    ---

- 클로저는 참조 타입 -> **순환 생성** ->  **"클로저에 의한 순환 참조"**

    ```swift
    HTMLElement 인스턴스
        ↓
    asHTML 클로저 프로퍼티
        ↓
    self를 캡처 -> HTMLElement 인스턴스
    ```

---

```swift
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello")
print(paragraph!.asHTML()) // <p>hello</p>

paragraph = nil
``` 

- `paragraph = nil` 로 **강한 참조** 를 끊었지만

- `deinit` 안에 있는 메시지가 출력되지 않음

    - 여전히 클로저가 `self` 를 **캡처** 하고 있어서 인스턴스가 **해제** 되지 않음

---

## 미리 막기 어려운 이유

- 클로저는 `lazy` 로 선언돼 있기 때문에
초기화가 끝나고 나서야 실행됨

- 그래서 `self` 를 참조할 수는 있지만,
그 안에서 **순환 참조** 가 생길 수 있음은 명확히 의도하지 않으면 쉽게 놓침

---

## 원본

- [공식문서 - Strong Reference Cycles for Closures](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/#Strong-Reference-Cycles-for-Closures)