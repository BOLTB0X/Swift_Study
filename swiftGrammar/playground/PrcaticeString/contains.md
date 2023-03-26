# contains

## contains(\_:)

> Returns a Boolean value indicating whether the sequence contains the given element.
> <br/>
> 시퀀스에 지정된 요소가 포함되어 있는지 여부를 나타내는 부울 값을 반환
> <br/>

즉 배열이든 문자열이든 특정 원소의 존재 여부를 Bool형으로 반환
<br/>

```swift
let cast = ["hahaah", "Park", "Kim", "Lee"]
print(cast.contains("kim")) // "true"
print(cast.contains("James")) // "false"
```

## contains(where:)

> Returns a Boolean value indicating whether the sequence contains an element that satisfies the given predicate.
> <br/>
> 주어진 조건자를 만족하는 요소가 시퀀스에 포함되어 있는지 여부를 나타내는 부울 값을 반환
> <br/>

즉 기존 contains에 조건문이 추가된 것이라 생각할 수 있음
<br/>

```swift
enum HTTPResponse {
    case ok
    case error(Int)
}

let lastThreeResponses: [HTTPResponse] = [.ok, .ok, .error(404)]
let hadError = lastThreeResponses.contains { element in
    if case .error = element {
        return true
    } else {
        return false
    }
}

print(hadError) // true
```

```swift
let arr = [21.37, 55.21, 9.32, 10.18, 388.77, 11.41]
let a = arr.contains { $0 > 100 }
// 시간 복잡도 O(n)

print(a) // true
```

## 참고

https://developer.apple.com/documentation/swift/string/contains(_:)
<br/>
https://developer.apple.com/documentation/swift/string/contains(where:)
