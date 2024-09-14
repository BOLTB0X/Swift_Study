## map (\_ : )

> Returns an array containing the results of mapping the given closure over the sequence’s elements.

```swift
func map<T>(_ transform: (Self.Element) throws -> T) rethrows -> [T]
```

시퀀스의 요소에 대해 지정된 클로저를 매핑한 결과가 포함된 새로운 배열을 반환

1. map

   ```swift
   let cast = ["Vivien", "Marlon", "Kim", "Karl"]
   let lowercaseNames = cast.map { $0.lowercased() }
   print(lowercaseNames) // ["vivien", "marlon", "kim", "karl"]

   let letterCounts = cast.map { $0.count }
   print(letterCounts) // [6, 6, 3, 4]
   ```

   <br/>

2. map 활용 - **배열에서 각 요소의 개수를 세어서 딕셔너리로 반환**

   ```swift
   let arr = ["a", "b", "a", "c", "b", "d"]
   var ret: [String : Int] = [:]

   arr.map { ret[$0, default: 0] += 1 }

   print(ret) // ["c": 1, "d": 1, "a": 2, "b": 2]
   ```

   <br/>

3. map 활용 - **배열에서 각 요소의 앞뒤로 특정 요소를 붙여서 새로운 배열을 반환**

   ```swift
   let arr = ["a", "b", "c"]

   arr.map { "*" + $0 + "*"} // ["*a*", "*b*", "*c*"]
   ```

   <br/>

4. map 활용 - **if - else**

   ```swift
   let array6 = [1, 2, 3]

   let array7 = array6.map {
       if $0 % 2 == 0  {
           return $0 * 2
       } else {
           return $0 * 2 + 1
       }
   }

   print(array7) // [3, 4, 7]
   ```

   <br/>

## 참고

[공식문서 - map](<https://developer.apple.com/documentation/swift/sequence/map(_:)>)
