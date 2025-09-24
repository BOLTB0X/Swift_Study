# Tuple

> A tuple type is a comma-separated list of types, enclosed in parentheses.

## 튜플(Tuple)이란?

여러 개의 값을 하나의 묶음으로 표현할 수 있는 타입

```swift
// 단순 튜플
let point: (Int, Int) = (3, 5)
print(point.0) // 3
print(point.1) // 5
```

값에 라벨(label) 을 붙여서 더 명확하게 표현할 수도 있음

```swift
// 라벨 있는 튜플
let labeledPoint: (x: Int, y: Int) = (x: 3, y: 5)
print(labeledPoint.x) // 3
print(labeledPoint.y) // 5
```

서로 다른 타입도 함께 묶을 수 있음

```swift
// 서로 다른 타입도 가능
let somthing: (String, Int, Bool) = ("Shose", 275, true)
print(somthing.0) // "Shose"
print(somthing.1) // 275
print(somthing.2) // true
```

---

## 튜플의 주요 고급 활용법

### - 다중 반환 값

함수에서 여러 값을 동시에 리턴할 때, 별도의 구조체를 만들지 않고 간단히 튜플을 활용

```swift
func minMax(of numbers: [Int]) -> (min: Int, max: Int)? {
    guard let first = numbers.first else { return nil }
        
    var minValue = first, maxValue = first
    
    for n in numbers {
        if n < minValue { minValue = n }
        if n > maxValue { maxValue = n }
    }
    
    return (min: minValue, max: maxValue)
}
```

```swift
if let result = minMax(of: [3, 7, 1, 9]) {
    print("min = \(result.min), max = \(result.max)")
} // min = 1, max = 9
```

---

### - 패턴 매칭

튜플은 분해(destructuring) 가 가능

```swift
let somthing: (String, Int, Bool) = ("Shose", 275, true)

let (shose, size, soldout) = somthing
print(shose) // Jordan
print(size)  //275
```

필요 없는 값은 `_` 로 무시 가능

```swift
let (x, _, z) = (1, 2, 3)
print(x, z) // 1 3
```

---

### - `switch` 패턴 매칭

```swift
let pos = (3, 0)

switch pos {
    case (0, 0):
        print("원점")
    case (let x, 0):
        print("x 축 위에 \(x)")
    case (0, let y):
        print("y 축 위에 \(y)")
    case (let x, let y) where x == y:
        print("둘다 같은 값 \(x) == \(y)")
    default:
        print("어딘가에 있겠지")
}
```

---

### - 딕셔너리 반복 시 활용

```swift
let dict = ["one": 1, "two": 2, "three": 3, "four": 4, "five": 5, "six": 6]

for (k, v) in dict {
    print(k, v)
}
```

---

### - Swift 표준 라이브러리 API에서의 활용

- `enumerated`

    ```swift
    let fruits = ["apple", "banana", "cherry"]

    for (index, fruit) in fruits.enumerated() {
        print("\(index): \(fruit)")
    }
    ```

    ---

- ex) `map`을 활용한 함수형 프로그래밍 스타일

    ```swift
    let numbers = [1, 2, 3, 4]

    let squaredWithIndex = numbers.enumerated().map { (index, value) in
        (index, value * value)
    }
    ```
---

### - 조건문에서의 활용

첫 번째 요소 비교, 같으면 두 번째 비교 

```swift
let a = (2, "apple")
let b = (2, "banana")

print(a < b) // true
```

---

### - 간단한 값 그룹핑

복잡한 모델을 정의할 필요 없고, 짧은 생명주기 데이터를 그룹화할 때 자주 사용

```swift
let httpResponse = (statusCode: 404, message: "Not Found")
print(httpResponse.statusCode) // 404
print(httpResponse.message)    // Not Found
```

---

## 참고

- [공식문서- Types:Tuple-Type](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/types/#Tuple-Type)

- [블로그 참고 - Swift) tuple(zeddios)](https://zeddios.tistory.com/238)

- [블로그 참고 - Swift:고급 문법 [패턴 - Patterns]: 튜플 패턴(Tuple Pattern)](https://seons-dev.tistory.com/entry/Swift-%EA%B3%A0%EA%B8%89-%EB%AC%B8%EB%B2%95-%ED%8C%A8%ED%84%B4-Patterns)