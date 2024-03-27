# String

> C언어 만큼이나 swift는 문자열을 다루기가 까다롭다

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

1. [String - 기본](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/String/stringComm.md)

2. [String - append, insert, replace, remove](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/String/insert.md)

3. [String - first, last](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/String/firstlast.md)

4. [String - Index](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/String/Index.md)

5. [String - contains](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/String/contains.md)

6. [String - hasPrefix, hasSuffix](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/String/hasSuffix.md)

7. [String - allSatisfy](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/String/allSatisfy.md)

8. [String - String 쪼개기](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/String/split.md)

## 자료 출처

[애플 개발자 공식문서 -String-](https://developer.apple.com/documentation/swift/string)

[swift 공식문서 -Strings and Characters-](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters/)
