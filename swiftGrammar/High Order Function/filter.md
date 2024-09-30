## filter (\_ : )

> Returns a new set containing the elements of the set that satisfy the given predicate.

```swift
func filter(_ isIncluded: (Element) throws -> Bool) rethrows -> Set<Element>
```

조건을 만족하는 요소 추출한 결과를 반환

filter로 전달되는 클로저의 리턴 타입은 Bool 이며 true일 경우 해당 요소를 반환

1. filter

   ```swift
   let shortNames = cast.filter { $0.count < 5 }
   print(shortNames) // ["Kim", "Karl"]
   ```

   ```swift
   let array8 = [1, 2, 3, 4, 5, 6, 7, 8, 9]
   print(array8.filter { $0 % 3 == 0}) // [3, 6, 9]
   ```

   <br/>

2. filter 활용 - 문자열 -> 문자열

   ```swift
   print("This is a test".filter{ $0 != " " }) // Thisisatest
   ```

   <br/>

3. filter 활용 - 딕셔너리 -> 딕셔너리

   ```swift
   let dict = ["apple": 5, "banana": 3, "orange": 7, "grape": 2]
   print(dict.filter { $0.value > 3 }) // ["orange": 7, "apple": 5]
   ```

   <br/>

4. filter 활용 - 혼합

   ```swift
   // 문자열에서 모음(a, e, i, o, u)의 개수를 세는
   word.filter { "aAiIoOuU".contains($0) }.count
   ```

   ```swift
   // 주어진 문자열에서 각 알파벳이 몇 번 나오는지 세는
   word.filter {
        let asci = UnicodeScalar(String($0))!.value
        return (asci >= 65 && asci <= 90) || (asci >= 97 && asci <= 122)
    }
   ```

   <br/>

[공식문서 - filter](<https://developer.apple.com/documentation/swift/set/filter(_:)>)
