## split(separator:maxSplits:omittingEmptySubsequences:)

> Returns the longest possible subsequences of the collection, in order, around elements equal to the given element.

```swift
func split(
    separator: Self.Element,
    maxSplits: Int = Int.max,
    omittingEmptySubsequences: Bool = true
) -> [Self.SubSequence]
```

- Parameters

  1. **separator**: 나눌 기준(String, Character)
  2. **maxSplits**: 나눌 최대 횟수
  3. **omittingEmptySubsequences**: true일 경우 연속된 구분자 사이에 있는 빈 부분을 무시
     <br/>

- Return Value: [Self.SubSequence]
  <br/>

- Complexity: O(n)

주로 split(separator: ) 으로 사용

- 예시

  ```swift
  let line = "BLANCHE:   I don't want realism. I want magic!"

  print(line.split(separator: " "))
  // ["BLANCHE:", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]

  print(line.split(separator: " ", maxSplits: 1))
  // ["BLANCHE:", "  I don\'t want realism. I want magic!"]

  print(line.split(separator: " ", omittingEmptySubsequences: false))
  // ["BLANCHE:", "", "", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]
  ```

## 참고

- [공식문서 - split](<https://developer.apple.com/documentation/swift/string/split(separator:maxsplits:omittingemptysubsequences:)>)
