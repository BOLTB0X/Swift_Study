## Accessing Subscripts of Optional Type

> subscript가 옵셔널 타입의 값(예: Swift 사전 유형의 키 subscript)을 반환하는 경우\
> <br/>
> subscript의 닫는 괄호 뒤에 ?를 배치하여 옵셔널 반환 값을 연결
> <br/>

```swift
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72
// the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81
```

<br/>

위의 예에서는 String 키를 Int 값 배열에 매핑하는 두 개의 키-값 쌍이 포함된 testScores라는 딕샤너리를 정의
<br/>

이 예제에서는 선택적 연결을 사용하여 "Dave" 배열의 첫 번째 항목을 91로 설정
<br/>
"Bev" 배열의 첫 번째 항목을 1씩 증가시킵니다. "Brian" 키에 대한 배열의 첫 번째 항목을 설정하려고 하는데 testScores 딕셔너리에 "Dave" 및 "Bev"에 대한 키가 포함되어 있으므로 처음 두 호출은 성공
<br/>

testScores 딕셔너리에 "Brian"에 대한 키가 포함되어 있지 않기 때문에 세 번째 호출은 실패
<br/>

## 자료 출처

[swift 공식문서 -Accessing Subscripts of Optional Type-](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/optionalchaining/#Accessing-Subscripts-of-Optional-Type)
