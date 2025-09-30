# replacingOccurrences

> Returns a new string in which all occurrences of a target string in the receiver are replaced by another given string.

iOS 2.0+ | iPadOS 2.0+ | Mac Catalyst 13.1+ | macOS 10.5+ | tvOS 9.0+ | visionOS 1.0+ | watchOS 2.0+

```swift
func replacingOccurrences(
    of target: String,
    with replacement: String
) -> String
```

## ex

```swift
let originalString = "안녕하세요, 스위프트입니다."
let newString = originalString.replacingOccurrences(of: "스위프트", with: "Swift")

print(originalString)
// 안녕하세요, 스위프트입니다.
print(newString)
// 안녕하세요, Swift입니다.
```

## 원본

- [공식문서 - replacingOccurrences](https://developer.apple.com/documentation/foundation/nsstring/replacingoccurrences(of:with:))