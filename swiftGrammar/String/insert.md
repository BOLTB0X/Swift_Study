## append

> Appends the given string/character to this string.

1. append(\_ other: String)

   ```swift
   mutating func append(_ other: String)
   ```

   ```swift
   var greeting = "Hello, "
   greeting.append("friend")

   print(greeting) // Hello, friend
   ```

2. append(\_ c: Character)

   ```swift
   mutating func append(_ c: Character)
   ```

   ```swift
   var globe = "Globe "
   globe.append("🌍")

   print(globe) // Globe 🌍
   ```

3. append(contentsOf newElements: String)

   ```swift
   mutating func append(contentsOf newElements: String)
   ```

   ```swift
   var haha = "haha"
   haha.append(contentsOf: " hoho")

   print(haha) // haha hoho
   ```

```swift
mutating func append(_ c: Character)
mutating func append(contentsOf newElements: String)
```

## insert

> Inserts a new character at the specified position.

```swift
mutating func insert(
    _ newElement: Character,
    at i: String.Index
)
```

- newElement 매개변수는 삽입할 문자
- 매개변수는 삽입할 위치를 나타내는 문자열의 인덱스(String.Index)

```swift
var ssstr = "Kofi"
let i = ssstr.index(ssstr.startIndex, offsetBy: 4) // 문자열의 인덱스는 정수값이 아니기 때문에
ssstr.insert("K", at: i) //KKofi

print(ssstr)
```

## replace

> Replaces the text within the specified bounds with the given characters.

```swift
mutating func replaceSubrange<C>(
    _ subrange: Range<String.Index>,
    with newElements: C
) where C : Collection, C.Element == Character
```

```swift
var str = "Hello World"
let idx = str.index(str.startIndex, offsetBy: 6)..<str.endIndex

print(str.replaceSubrange(idx, with: "Swift")) // Hello Swift
```

## remove

> Removes and returns the character at the specified position.

```swift
@discardableResult
mutating func remove(at i: String.Index) -> Character
```

```swift
var str = "Hello"
str.remove(at: str.index(before: str.endIndex)) // "Hell"
```

## removeFirst

```swift
@discardableResult
mutating func removeFirst() -> Self.Element
```

```swift
var str = "Swift"
str.removeFirst()

print(str) // wift
```

## removeLast

```swift
@discardableResult
mutating func removeLast() -> Self.Element
```

```swift
var str = "Swift"
str.removeLast()

print(str) // Swif
```

## removeSubrange

```swift
mutating func removeSubrange(_ bounds: Range<String.Index>)
```

```swift
var str = "Hello, Swift"
let range = str.index(str.startIndex, offsetBy: 7)..<str.endIndex
str.removeSubrange(range)

print(str) // Hello,
```

## dropFirst

```swift
func dropFirst(_ k: Int = 1) -> Self.SubSequence
```

removeFirst와 다르게 새 부분문자열(SubSequence) 을 생성하여 반환하므로 메서드의 반환 값을 받아줄 변수가 필요

```swift
var str = "Hello, Swift"

print(str.dropFirst()) // ello, Swift

print(str.dropFirst(7)) // "Swift"
```

## dropLast

```swift
func dropLast(_ k: Int) -> Self.SubSequence
```

dropFirst 와 마찬가지

```swift
let str = "Swift"
let str2 = str.dropLast()

print(str2) // "Swif"

let str = "Swift"

let str3 = str.dropLast(3)

print(str3) // "Sw"
```

## 참고

[공식문서 - String](https://developer.apple.com/documentation/swift/string/)
