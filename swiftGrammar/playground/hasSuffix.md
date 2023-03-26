## hasPrefix(\_:)

```swift
func hasPrefix(_ prefix: String) -> Bool
```

문자열이 어떤 글자로 시작하는지 확인하여 Bool형 반환
<br/>

```swift
let stringArr = ["sam", "coco", "Thierry", "Sherry", "John"]

for item in stringArr {
    if item.hasPrefix("s") {
        print("통과 O : \(item)")
    } else {
        print("통과 X")
    }

//    통과 O : sam
//    통과 X
//    통과 X
//    통과 X
//    통과 X
}
```

## hasSuffix(\_:)

```swift
func hasSuffix(_ suffix: String) -> Bool
```

문자열이 어떤 글자로 끝나는지 확인하여 Bool형 반환
<br/>

```swift
let stringArr2 = ["sam", "coco", "Thierry", "Sherry", "John"]

for item in stringArr2 {
    if item.hasSuffix("y") {
        print("통과 O : \(item)")
    } else {
        print("통과 X")
    }

//    통과 X
//    통과 X
//    통과 O : Thierry
//    통과 O : Sherry
//    통과 X
}
```

---

## 참고

https://developer.apple.com/documentation/swift/string/hasprefix(_:)
<br/>

https://developer.apple.com/documentation/swift/string/hassuffix(_:)
<Br/>
