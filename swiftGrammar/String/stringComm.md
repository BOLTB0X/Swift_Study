## 기본 속성

> 문자열은 컬렉션을 형성하는 "Swift"와 같은 일련의 문자
> <br/>

- count (Int): 문자열 길이 확인 메소드
  <br/>

- isEmpty (Bool): 빈 문자열 확인
  <br/>

- init(repeating: String, count: Int): 반복되는 문자열로 초기화
  <br/>

- init(format: String, CVarArg...): 포맷 활용하기
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
