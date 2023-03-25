## 인덱스를 찾아주는 편리한 함수들

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
