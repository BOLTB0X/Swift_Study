# String <-> Array

Array을 String으로 하려면 [joined()]() 이용

## Intro

```swift
let str1 = "Hi"
let str2 = str2.map { $0 } // 배열로 변경

print(str2.joined()) // error
```

```
'String.Element' (aka 'Character') and 'String' be equivalent (requirement specified as 'Self.Element' == 'String')
```

String 타입을 map으로 Array로 변환한 뒤, 다시 joined를 사용하여 String으로 변경하려 하면 컴파일 에러

## FlattenSequence

> joined의 반환 값은 FlattenSequence<Self>

Array 내의 원소들이 **Sequence**를 따르는 타입이어야 하고, 그 **Sequence**를 평탄화(flatten)하면서 결합한다는 의미

문자열을 결합하기 위해서는 Array 원소들이 반드시 String 타입이어야 함

```swift
let str2 = str2.map { $0 } // 배열로 변경
```

[map](https://github.com/BOLTB0X/Swift_Study/blob/main/swiftGrammar/High%20Order%20Function/map.md)(배열의 각 요소를 변환하는 고차함수)을 통해 반환되는 Array의 타입과 joined가 처리할 수 있는 Array의 타입이 맞지 않음

- str2: [Character]
- joined()는 [String] 이어야 사용 가능

## Sol

1. joined()을 사용하는 경우

```swift
let str1 = "Hi"
let str2 = str1.map { String($0) }

print(str2.joined())
// Hi
```

2. 타입 변환

```swift
let str3 = "Bye"
let str4 = Array(str3)

print(String(str4))
// Bye
```

## 참고

- [공식문서 - joined()](<https://developer.apple.com/documentation/swift/sequence/joined()>)

- [공식문서 - FlattenSequence](https://developer.apple.com/documentation/swift/flattensequence)
