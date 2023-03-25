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

## 기본 속성

- 문자열 길이 확인 count (Int)
  <br/>

- 빈 문자열 확인 isEmpty (Bool)
  <br/>

- 반복되는 문자열로 초기화 init(repeating: String, count: Int)
  <br/>

- 포맷 활용하기 init(format: String, CVarArg...)
  <br/>

- 문자열 삽입: ex) "element : \(c)"
  <br/>

## 문자열 삽입

```swift
"element : \(c)"
```

<br/>

## 문자열 결합

```swift
let str:String = "swift"
let str2 = "스위프트"

print(str+str2) // swift스위프트
```

## 문자열 비교

아스키 코드로 계산함
<br/>

```swift
let a = "1"
let b = "2"
let c = "a"
let d = "b"

print(a > b) // false
print(c < d) // true
```

## 참고

- https://tngusmiso.tistory.com/46
  <br/>
- https://developer.apple.com/documentation/swift/string
