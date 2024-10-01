# split vs components

[split](https://github.com/BOLTB0X/Swift_Study/blob/main/study/Split-Components/split.md)은 빈 문자열을 무시, [components](https://github.com/BOLTB0X/Swift_Study/blob/main/study/Split-Components/components.md)는 빈 문자열도 처리해야 하거나, 문자열을 새로 복사해야 할 때 사용

## Return Value

- split -> [Substring]

  ```swift
  func split(
    separator: Self.Element,
    maxSplits: Int = Int.max,
    omittingEmptySubsequences: Bool = true
  ) -> [Self.SubSequence]
  ```

  <br/>

- components -> [String]
  ```swift
  func components(separatedBy separator: String) -> [String]
  ```

## 빈 문자열 처리

- split: 연속된 구분자를 만나면 빈 문자열을 무시

  ```swift
  let line = "BLANCHE:   I don't want realism. I want magic!"

  print(line.split(separator: " "))
  // ["BLANCHE:", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]
  ```

  <br/>

- components: 연속된 구분자를 만나면 빈 문자열을 포함

  ```swift
  let str = "Hello,World,,Swift"

  let result = str.components(separatedBy: ",")

  print(result)
  // ["Hello", "World", "", "Swift"]
  ```

## 구분자(separator) 타입

- **split**: Character 또는 String
  <br/>
- **components**: String을 사용해 분할

## 참고

- [공식문서 - split](<https://developer.apple.com/documentation/swift/string/split(separator:maxsplits:omittingemptysubsequences:)>)

- [공식문서 - components](https://developer.apple.com/documentation/foundation/nsstring/1413214-components)

- [스택오버플로우 참조](https://stackoverflow.com/questions/46344649/componentseparatedby-versus-splitseparator)
