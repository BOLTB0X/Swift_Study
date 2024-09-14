## reduce ( )

> Returns the result of combining the elements of the sequence using the given closure.

```swift
func reduce<Result>(
    _ initialResult: Result,
    _ nextPartialResult: (Result, Self.Element) throws -> Result
) rethrows -> Result
```

초기값과 클로저, 두 개의 파라미터를 전달받고 각 요소에 대하여 클로저 내에서 처리하여 초기값에 누적하여 결합

1. reduce

   ```swift
   let numbers = [1, 2, 3, 4]
   let numberRes = numbers.reduce(0, { x, y in
       x + y + x + x + y + y - 1
   })

   print(numberRes) // 134

   numberRes = numbers.reduce(0, { $0 + $1}) // $0 은 초기 값 , $1 요소
   ```

   <br/>

2. reduce 활용

   ```swift
   print(numbers.reduce(0, +)) // 10
   print(numbers.reduce(0, -)) // -10
   print(numbers.reduce(1, *)) // 24
   print(numbers.reduce(1, /)) // 0
   ```

   <br/>

3. reduce 활용 - 딕셔너리 정의

   ```swift
   let strDic = "appleisgood".reduce(into: [:]) {
    $0[$1, default: 0] += 1
   }

   print(strDic) // "a": 1, "o": 2, "i": 1, "d": 1, "p": 2, "e": 1, "l": 1, "s": 1, "g": 1]
   ```

   <br/>

## 참고

[공식문서 - reduce](<https://developer.apple.com/documentation/swift/sequence/reduce(_:_:)>)
