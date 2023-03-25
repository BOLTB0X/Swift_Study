# contains

1. contains(\_:)
   > Returns a Boolean value indicating whether the sequence contains the given element.
   > <br/>

특정 문자를 포함하고 있는 여부만 알고 싶다면 contains 이용, 인자로는 Character 형 문자를 넘겨주고 결과값은 Bool 형
<br/>

```swift
let tmp = "Apple"
print(tmp.contains("A")) // true
print(tmp.contains("a")) // false
```

배열에서도 사용 가능
<br/>

```swift
let cast = ["Vivien", "Marlon", "Kim", "Karl"]
print(cast.contains("Marlon"))
// Prints "true"
print(cast.contains("James"))
// Prints "false"
```

<br/>

2. contains(where:)

> Returns a Boolean value indicating whether the sequence contains an element that satisfies the given predicate.
> <br/>

주어진 조건자를 만족하는 요소가 시퀀스에 포함되어 있는지 여부를 나타내는 Bool 값을 반환
<br/>

```swift
// 공시문서 코드
enum HTTPResponse {
    case ok
    case error(Int)
}

let lastThreeResponses: [HTTPResponse] = [.ok, .ok, .error(404)]

// 시퀀스에 있으면 참 반환
let hadError = lastThreeResponses.contains { element in
    if case .error = element {
        return true
    } else {
        return false
    }
}
// 'hadError' == true
```

고차함수와 활용 가능
<br/>

```swift
let arr1 = [21.37, 55.21, 9.32, 10.18, 388.77, 11.41]

let arr2 = arr1.contains { $0 > 100 }

print(arr2) // 388.77
```

---

## 참고

https://developer.apple.com/documentation/swift/array/contains(where:)
<br/>
