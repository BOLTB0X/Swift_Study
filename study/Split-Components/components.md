## components(separatedBy:)

> Returns an array containing substrings from the receiver that have been divided by a given separator.

```swift
func components(separatedBy separator: String) -> [String]
```

- Parameters

  1. separator: 나눌 기준(String)
     <br/>

- Return Value

  > An NSArray object containing substrings from the receiver that have been divided by separator.

  위 문자열을 포함하는 NSArray 개체 == **[String]**
  <br/>

- Complexity: O(n)

주어진 문자열 또는 문자열 집합을 기준으로 문자열을 분할

**연속된 구분자를 만나면 빈 문자열도 포함하여 반환**

- 예시

  ```swift
  let str = "Hello,World,,Swift"

  let result = str.components(separatedBy: ",")

  print(result)
  // ["Hello", "World", "", "Swift"]
  ```

## 참고

- [공식문서 - components](https://developer.apple.com/documentation/foundation/nsstring/1413214-components)
