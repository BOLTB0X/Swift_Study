# Letter case(대소문자)

cf. `Character` 일 떄 사용 가능

## Upper

### `isUppercase`

> A Boolean value indicating whether this character is considered uppercase.

iOS 8.0+ | iPadOS 8.0+ | Mac Catalyst 13.0+ | macOS 10.10+ | tvOS 9.0+ |visionOS 1.0+ | watchOS 2.0+

```swift
var isUppercase: Bool { get }
```

```swift
let A : Character = "A"

print(A.isUppercase) // true

let a: [Character] = ["A", "B", "C", "d", "E", "F", "g", "h", "I", "J", "K", "L", "m", "N", "O", "P", "Q", "r",]

for ele in a {
    print(ele.isUppercase)
}

// true
// true
// true
// false
// true
// true
// false
// false
// true
// true
// true
// true
// false
// true
// true
// true
// true
// false
```

---

### `uppercased()`

> Returns an uppercased version of this character.

iOS 8.0+ | iPadOS 8.0+ | Mac Catalyst 13.0+ | macOS 10.10+ | tvOS 9.0+ | visionOS 1.0+ | watchOS 2.0+

```swift
func uppercased() -> String
```

```swift
let chars: [Character] = ["e", "é", "и", "π", "ß", "1"]
for ch in chars {
    print(ch, "-->", ch.uppercased())
}

// e --> E
// é --> É
// и --> И
// π --> Π
// ß --> SS
// 1 --> 1
```

---

### `isLowercase`

> A Boolean value indicating whether this character is considered lowercase.

iOS 8.0+ | iPadOS 8.0+ | Mac Catalyst 13.0+ | macOS 10.10+ | tvOS 9.0+ | visionOS 1.0+ | watchOS 2.0+

```swift
var isLowercase: Bool { get }
```

```swift
let b: [Character] = ["a", "b", "C", "d", "E", "F", "g", "h", "i", "J", "k", "L", "m", "N", "O", "P", "Q", "r",]

for ele in b {
    print(ele.isLowercase)
}

// true
// true
// false
// true
// false
// false
// true
// true
// true
// false
// true
// false
// true
// false
// false
// false
// false
// true
```

---

### `lowercased()`

> Returns a lowercased version of this character.

iOS 8.0+ | iPadOS 8.0+ | Mac Catalyst 13.0+ | macOS 10.10+ | tvOS 9.0+ | visionOS 1.0+ | watchOS 2.0+

```swift
func lowercased() -> String
```

```swift
let chars: [Character] = ["E", "É", "И", "Π", "1"]
for ch in chars {
    print(ch, "-->", ch.lowercased())
}

// E --> e
// É --> é
// И --> и
// Π --> π
// 1 --> 1
```

---

## `isNumber`

> A Boolean value indicating whether this character represents a number.

iOS 8.0+ | iPadOS 8.0+ | Mac Catalyst 13.0+ | macOS 10.10+ | tvOS 9.0+ | visionOS 1.0+ | watchOS 2.0+

```swift
var isNumber: Bool { get }
```

```swift
print(Character("1").isNumber) // true
print(Character("a").isNumber) // false
```

---

## 참고

- [공식문서 - isUppercase](https://developer.apple.com/documentation/swift/character/isuppercase)

- [공식문서 - uppercased()](https://developer.apple.com/documentation/swift/character/uppercased())

- [공식문서 - isLowercase](https://developer.apple.com/documentation/swift/character/islowercase)

- [공식문서 - lowercased()](https://developer.apple.com/documentation/swift/character/lowercased())

- [공식문서 - isNumber](https://developer.apple.com/documentation/swift/character/isnumber)