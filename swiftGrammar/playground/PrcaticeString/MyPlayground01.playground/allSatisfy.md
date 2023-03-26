## allSatisfy(\_:)

> Returns a Boolean value indicating whether every element of a sequence satisfies a given predicate.
> <br/>
> 시퀀스의 모든 요소가 주어진 조건자를 만족하는지 여부를 나타내는 부울 값을 반환
> <br/>

즉 시퀀스가 조건에 모두 만족하는 지 체크하는 함수
<br/>

```swift
let stringArr = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]

let allHaveAtLeastFive = stringArr.allSatisfy({ $0.count >= 5 })

print(allHaveAtLeastFive) // true
```

---

## 참고

https://developer.apple.com/documentation/swift/string/allsatisfy(_:)
