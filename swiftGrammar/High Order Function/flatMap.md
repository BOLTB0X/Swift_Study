## flatMap(\_ : )

> Returns an array containing the concatenated results of calling the given transformation with each element of this sequence.

```swift
func flatMap<SegmentOfResult>(_ transform: (Self.Element) throws -> SegmentOfResult) rethrows -> [SegmentOfResult.Element] where SegmentOfResult : Sequence
```

컨테이너의 각 요소를 사용하여 지정된 조건을 호출할 때, 순차적인 결과의 시퀀스를 반환

```swift
let ar = [1, 2, 3, 4]

let mapped = ar.map { Array(repeating: $0, count: $0) }
// [[1], [2, 2], [3, 3, 3], [4, 4, 4, 4]]

let flatMapped = ar.flatMap { Array(repeating: $0, count: $0) }
// [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
```

## 참고

[공식문서 - flatMap](<https://developer.apple.com/documentation/swift/string/flatmap(_:)-i3m9>)
