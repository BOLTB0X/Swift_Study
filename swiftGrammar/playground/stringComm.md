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
