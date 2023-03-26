# String in Swift

> C언어 만큼이나 swift는 문자열을 다루기가 까다롭다
> <br/>

## 작성하게 된 계기

```swift
let str:String = "swift"

for c in str {
    print("element : \(c), type: \(type(of: c))")
    //    element : s, type: Character
    //    element : w, type: Character
    //    element : i, type: Character
    //    element : f, type: Character
    //    element : t, type: Character

}
```

<br/>
이런 식으로 문자열을 쪼개면 type이 Character으로 변하게 됌 그러면
<br/>

```swift
let str:String = "swift"
var tmp = ""

for c in str {
  tmp += c
}
```

이렇게 사용할 수가 없음 그래서 관련 함수들을 정리하고 함
<br/>

## 목록

1. [문자열 기본](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/playground/PrcaticeString/stringComm.md)
   <br/>

2. 인덱스 관련 (firstIndex, lastIndex.....)

- [first, last]()
  <br/>

- [Chararcter Index Find(firstIndex, lastIndex)](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/playground/PrcaticeString/MyPlayground01.playground/chararcterFindIndex.md)
  <br/>

- [Index Find(startIndex, lastIndex))](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/playground/PrcaticeString/MyPlayground01.playground/IndexFind.md)
  <br/>

3. Bool형 반환

- [contains](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/playground/PrcaticeString/MyPlayground01.playground/contains.md)
  <br/>

- [hasPrefix과 hasSuffix]()
  <br/>

- [allSatisfy]()
  <br/>

## 참고

- https://tngusmiso.tistory.com/46
  <br/>
- https://developer.apple.com/documentation/swift/string
