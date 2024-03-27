## split

> Returns the longest possible subsequences of the collection, in order, around elements equal to the given element

- 문자열을 지정된 구분자를 기준으로 분할하여 [Self.SubSequence]로 반환

- **시간 복잡도: O(n)**

```swift
func split(
    separator: Self.Element,
    maxSplits: Int = Int.max,
    omittingEmptySubsequences: Bool = true
) -> [Self.SubSequence]
```

```swift
// 예시
let line = "BLANCHE:   I don't want realism. I want magic!"
print(line.split(separator: " "))
// ["BLANCHE:", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]
```

- maxSplits
  공백 문자(" ")에서 문자열을 분할할 때 maxSplits 및 omittingEmptySubsequences 매개 변수
  <br/>

  분할을 처음 사용하면 원래 하나 이상의 공백으로 구분된 각 단어가 반환
  <br/>

  maxSplits 매개변수에 1을 전달하므로 원래 문자열이 두 개의 새 문자열로 한 번만 분할 됨

  ```swift
  print(line.split(separator: " ", maxSplits: 1))
  // ["BLANCHE:", "  I don\'t want realism. I want magic!"]
  ```

- omittingEmptySubsequences
  매개 변수에 대해 false를 전달하므로 반환된 배열에는 공백이 반복되는 빈 문자열이 포함

  ```swift
  print(line.split(separator: " ", omittingEmptySubsequences: false))
  // ["BLANCHE:", "", "", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]
  ```

## components

> Returns an array containing substrings from the string that have been divided by characters in the given set.

- 문자열을 지정된 문자열을 기준으로 분할하여 [String]로 반환

- separatedBy 매개변수는 문자열을 분할할 구분자

- **시간 복잡도: O(n)**

```swift
func components(separatedBy separator: CharacterSet) -> [String]
```

```swift
let str = "인생,서글퍼,힘내자"
let splitedStr = str.components(separatedBy: ",")

print(splitedStr) // ["인생", "서글퍼", "힘내자"]
```
