# Mutating

`mutating` 키워드는 **구조체** 나 **열거형** 에서 자기 자신의 상태를 변경할 때 꼭 필요한 키워드

---

## 왜 필요한가?

> Swift에서 `struct`와 `enum` 은 **value type**

값 타입은 변수에 복사되어 전달되기 때문에, 인스턴스의 메서드 내부에서 자기 자신(`self`)의 프로퍼티를 바꾸면, *"복사본을 바꾸는 것인지 원본을 바꾸는 것인지"* 모호해질 수 있음

Swift는 기본적으로 인스턴스 메서드 내부에서 self 수정 금지

-> 단, 정말 의도적으로 수정하려면 `mutating` 키워드를 붙여야 함

---

## Ex - struct

```swift
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 2.0, y: 3.0)

print("The point is now at (\(somePoint.x), \(somePoint.y))")
```

---

## Ex - enum

```swift
enum SwitchState {
    case on, off
    
    mutating func toggle() {
        self = (self == .on) ? .off : .on
    }
}

var s = SwitchState.off
s.toggle() // on
s.toggle() // off
```

## 참고

- [공식문서 - Modifying Value Types from Within Instance Methods
](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/methods/#Modifying-Value-Types-from-Within-Instance-Methods)