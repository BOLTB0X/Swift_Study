# String 관련 함수

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

## 기본 속성1

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

## 기본 속성2

### 문자열 삽입

```swift
"element : \(c)"
```

<br/>

### 문자열 결합

```swift
let str:String = "swift"
let str2 = "스위프트"

print(str+str2) // swift스위프트
```

### 문자열 비교

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

### 인덱스를 찾아주는 편리한 함수들

1. startIndex
   문자열의 시작 요소 인덱스를 Int형으로 반환
   <br/>

```swift
print(str[str.startIndex]) // s
```

<br/>

2. endIndex
   문자열의 마지막 요소 인덱스의 다음 인덱스를 Int형으로 반환
   <br/>

3. Index

- index(before:String.Index)
  인자로 들어온 인덱스 1칸 앞의 인덱스를 반환
  <br/>

```swift
print(str[str.index(before: str.endIndex)]) // t
```

<br/>

- index(after:String.Index)
  인자로 들어온 인덱스 1칸 뒤의 인덱스를 반환
  <br/>

```swift
print(str[str.index(after: str.startIndex)]) // w
```

<br/>

- index(String.Index, offsetBy: String.IndexDistance)
  인자로 들어온 인덱스와 offsetBy 차이만큼 떨어진 인덱스를 반환
  <br/>

```swift
print(str[str.index(str.startIndex, offsetBy: 2)]) // i
print(str[str.index(str.endIndex, offsetBy: -2)]) // f
```

<br/>

### 특정 문자의 인덱스를 찾는 함수

- firstIndex(of: Character)
  인자로 들어온 문자가 첫번째에서 몇번째 인덱스에 있는지 (Optional)로 반환해줌
  <br/>
  배열에서도 사용 가능
  <br/>

```swift
let tmpstr = "hello swift"
if let index = tmpstr.firstIndex(of: "o") {
    print(index) // 4
}
```

<br/>

- lastIndex(of: Character)
  인자로 들어온 문자가 마지막에서 몇번째 인덱스에 있는지 (Optional)로 반환해줌
  배열에서도 사용 가능
  <br/>

```swift
if let index = tmpstr.lastIndex(of: "o") {
    print(index)
}
```

### contains(\_:)

특정 문자를 포함하고 있는 여부만 알고 싶다면 contains 이용, 인자로는 Character 형 문자를 넘겨주고 결과값은 Bool 형
<br/>

```swift
let tmp = "Apple"
print(tmp.contains("A")) // true
print(tmp.contains("a")) // false
```

## 참고

- https://tngusmiso.tistory.com/46
  <br/>
- https://developer.apple.com/documentation/swift/string
