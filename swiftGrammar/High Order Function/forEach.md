## forEach(\_ : )

> Calls the given closure on each element in the sequence in the same order as a for-in loop.

```swift
func forEach(_ body: (Self.Element) throws -> Void) rethrows
```

```swift
let numberWords = ["one", "two", "three"]

numberWords.forEach { word in
    print(word)
    // one
    // two
    // three
}
```

## 참고

[공식문서 - forEach](<https://developer.apple.com/documentation/swift/array/foreach(_:)>)
