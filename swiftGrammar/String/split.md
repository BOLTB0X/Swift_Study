## split

> 주어진 요소와 동일한 요소 주위에서 컬렉션의 가능한 가장 긴 하위 시퀀스를 순서대로 반환
> <br/>

```swift
func split(
    separator: Self.Element,
    maxSplits: Int = Int.max,
    omittingEmptySubsequences: Bool = true
) -> [Self.SubSequence]
```

<br/>

공백 문자(" ")에서 문자열을 분할할 때 maxSplits 및 omittingEmptySubsequences 매개 변수
<br/>

분할을 처음 사용하면 원래 하나 이상의 공백으로 구분된 각 단어가 반환
<br/>

```swift
let line = "BLANCHE:   I don't want realism. I want magic!"
print(line.split(separator: " "))
// 출력 "["BLANCHE:", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]"
```

<br/>

maxSplits 매개변수에 1을 전달하므로 원래 문자열이 두 개의 새 문자열로 한 번만 분할 됨
<br/>

```swift
print(line.split(separator: " ", maxSplits: 1))
// 출력 "["BLANCHE:", "  I don\'t want realism. I want magic!"]"
```

<br/>

omittingEmptySubsequences 매개 변수에 대해 false를 전달하므로 반환된 배열에는 공백이 반복되는 빈 문자열이 포함
<br/>

```swift
print(line.split(separator: " ", omittingEmptySubsequences: false))
// 출력 "["BLANCHE:", "", "", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]"
```

<br/>

split **시간 복잡도: O(n)**
