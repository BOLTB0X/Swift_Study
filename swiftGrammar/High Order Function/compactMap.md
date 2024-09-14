## compactMap(\_ : )

> Returns an array containing the non-nil results of calling the given transformation with each element of this sequence.

```swift
func compactMap<ElementOfResult>(_ transform: (Self.Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult]
```

각 요소에 함수를 적용하고, 그 결과가 nil이 아닌 요소들로 이루어진 새로운 시퀀스를 반환

시간 복잡도 O(n)

```swift
let possibleNumbers = ["1", "2", "three", "///4///", "5"]


let mapped: [Int?] = possibleNumbers.map { str in Int(str) }
// [1, 2, nil, nil, 5]


let compactMapped: [Int] = possibleNumbers.compactMap { str in Int(str) }
// [1, 2, 5]
```

## 참고

[공식문서 - compactMap](<https://developer.apple.com/documentation/swift/sequence/compactmap(_:)>)
