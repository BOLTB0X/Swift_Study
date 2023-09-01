## first(where:)

> Returns the first element of the sequence that satisfies the given predicate.
> <br/>
> 주어진 조건자를 만족하는 시퀀스의 첫 번째 요소를 옵셔널로 반환
> <br/>

즉 조건애 맞는 원소를 인덱스 0부터 찾아 조간이 맞으면 옵셔널로 반환
<br/>

```swift
let arr = [-3, 5, 2, -2, 9, -6, 10, 1]

if let firstNegative = arr.first(where: { $0 < 0 }) {

    print("The first negative number is \(firstNegative).") // "The first negative number is -2."

    // 시간 복잡도 O(n)
}
```

## last(where:)

> Returns the last element of the sequence that satisfies the given predicate.
> <br/>
> 주어진 조건자를 만족하는 시퀀스의 마지막 요소를 반환
> <br/>

즉 조건애 맞는 원소를 인덱스 끝부터 찾아 조간이 맞으면 옵셔널로 반환
<br/>

```swift
let arr = [3, 5, 4, -2, 9, -6, 10, 20]

if let lastNegative = arr.last(where: { $0 < 0 }) {
    print("The last negative number is \(lastNegative).") // "The last negative number is -6."
}

// 시간 복잡도 O(n)
```

---

## 참고

https://developer.apple.com/documentation/swift/string/first(where:)
<br/>
https://developer.apple.com/documentation/swift/string/last(where:)
<br/>
