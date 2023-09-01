## startIndex

> The position of the first character in a nonempty string.
> <br/>
> 비어 있지 않은 문자열에서 첫 번째 문자의 위치
> <br/>

즉 비어있지 않은 문자열의 첫번째 인데스 반환
<br/>

```swift
let str = "ABCDEFG"

print(str[str.startIndex]) // A
```

## endIndex

> A string’s “past the end” position—that is, the position one greater than the last valid subscript argument.
> <br/>
> 문자열의 "끝을 지난" 위치, 즉 마지막 유효한 아래 첨자 인수보다 하나 큰 위치
> <br/>

즉 문자열의 마지막 요소 다음을 인덱스 반환
<br/>

```swift
let str = "ABCDEFG"

print(str[str.endIndex]) // 에러
```

## index

- index(after:)
  > Returns the position immediately after the given index.
  > <br/>
  > 인덱스 바로 뒤의 위치를 ​​반환
  > <br/>

```swift
let str = "ABCDEFG"

str[str.index(after: str.startIndex)] // B
```

- index(before:)
  > Returns the position immediately before the given index.
  > <br/>
  > 인덱스 바로 앞의 위치를 반환
  > <br/>

```swift
let str = "ABCDEFG"

str[str.index(before: str.endIndex)] // G
```

- index(\_:offsetBy:)
  > Returns an index that is the specified distance from the given index.
  > <br/>
  > 지정된 인덱스에서 지정된 거리만큼 떨어진 인덱스를 반환
  > <br/>

```swift
let s = "Swift"
let i = s.index(s.startIndex, offsetBy: 4)

print(s[i]) // "t"
// 시간 복잡도 O(n)
```

- index(\_:offsetBy:limitedBy:)
  > Returns an index that is the specified distance from the given index, unless that distance is beyond a given limiting index
  > <br/>
  > 해당 거리가 지정된 제한 인덱스를 벗어나지 않는 한 지정된 인덱스에서 지정된 거리인 옵셔널 인덱스를 반환
  > <br/>

```swift
let s = "Swift"

if let i = s.index(s.startIndex, offsetBy: 4, limitedBy: s.endIndex) {
    print(s[i]) // t
}
// 시간 복잡도 O(n)
```

<br/>

```swift
let j = s.index(s.startIndex, offsetBy: 6, limitedBy: s.endIndex)
print(j) // nil

```

## firstIndex

- firstIndex(of:)
  > Returns the first index where the specified value appears in the collection.
  > <br/>
  > 즉 문자열 내 파라미터로 전달한 문자를 검색하여 Index를 리턴
  > <br/>

즉 인자로 들어온 문자가 몇번째 위치에 있는 Optional 타입 인덱스 반환

```swift
var students = ["Ben", "Ivy", "Jordell", "Maxime"]

if let i = students.firstIndex(of: "Maxime") {
    students[i] = "Max"
}
print(students) // "["Ben", "Ivy", "Jordell", "Max"]"

// 시간 복잡도 O(n)
```

- firstIndex(where:)
  > Returns the first index in which an element of the collection satisfies the given predicate.
  > <br/>
  > 컬렉션의 요소가 주어진 조건자를 만족하는 첫 번째 인덱스를 리턴
  > <br/>

즉 인자로 들어온 문자와 조건에 맞는 몇번째 위치에 있는 Optional 타입 인덱스 반환

```swift
let students2 = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]

if let i = students2.firstIndex(where: { $0.hasPrefix("A") }) {
    print("\(students2[i]) starts with 'A'!") // "Abena starts with 'A'!"
}
// 시간 복잡도 O(n)
```

## lastIndex

- lastIndex(of:)
  > Returns the last index where the specified value appears in the collection.
  > <br/>
  > 즉 문자열 내 파라미터로 전달한 문자를 검색하여 Index를 리턴
  > <br/>

즉 인자로 들어온 문자가 뒤에서 부터 몇번째 위치에 있는 Optional 타입 인덱스 반환

```swift
var students3 = ["Ben", "Ivy", "Jordell", "Ben", "Maxime"]

if let i = students3.lastIndex(of: "Ben") {
    students3[i] = "Benjamin"
}

print(students3) // "["Ben", "Ivy", "Jordell", "Benjamin", "Max"]"
// 시간 복잡도 O(n)
```

- lastIndex(where:)
  > Returns the index of the last element in the collection that matches the given predicate.
  > <br/>
  > 지정된 술어와 일치하는 컬렉션의 마지막 요소 인덱스를 반환
  > <br/>

즉 인자로 들어온 문자와 조건에 맞는 몇번째 위치를 뒤에서부터 세어 Optional 타입 인덱스 반환

```swift
let students4 = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]

if let i = students4.lastIndex(where: { $0.hasPrefix("A") }) {
    print("\(students4[i]) starts with 'A'!") // "Akosua starts with 'A'!"
}
// 시간 복잡도 O(n)
```

---

## 자료 출처

https://developer.apple.com/documentation/swift/string/lastindex(where:)
<br/>
https://developer.apple.com/documentation/swift/string/index(before:)#parameters
<br/>
https://developer.apple.com/documentation/swift/string/index(_:offsetby:)
<br/>
https://developer.apple.com/documentation/swift/string/index(_:offsetby:limitedby:)
<br/>
https://hongssup.tistory.com/258
<br/>
