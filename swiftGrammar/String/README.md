# String

> C언어 만큼이나 swift는 문자열을 다루기가 까다롭다
> <br/>

## Intro

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

또한 python이나 C++처럼 for문으로 인덱스로 순회하고 싶어도 Int형으로 접근이 불가
<br/>

```swift
let s: String = "hello"
var tmp:String = ""

for i in 0..<5 {
  tmp += s[i] // 에러
}

```

## 목록

1. 기본

- [문자열 기본](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/String/stringComm.md)
  <br/>

- [삽입](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/String/insert.md)
  <br/>

2. 인덱스 관련

- [first, last](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/String/firstlast.md)
  <br/>

- [Index](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/String/Index.md)
  <br/>

3. Bool형 반환

- [contains](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/String/contains.md)
  <br/>

- [hasPrefix, hasSuffix](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/String/hasSuffix.md)
  <br/>

- [allSatisfy](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/String/allSatisfy.md)
  <br/>

4. 기타

- [split](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/String/split.md)
  <br/>

- [배열을 문자열로](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/String/stringApply.md)

## 자료 출처

[애플 개발자 공식문서 -String-](https://developer.apple.com/documentation/swift/string)
<br/>

[swift 공식문서 -Strings and Characters-](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters/)
