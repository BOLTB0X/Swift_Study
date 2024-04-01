# Higher-Order Function(고차함수)

> Argument(인자) 로 함수를 전달 받거나 실행 결과로 함수를 반환하는 함수

Swift에서 함수는 일급 객체이므로 함수를 다루는 것이 가능하며, 고차 함수는 이러한 함수형 프로그래밍의 개념을 기반으로함

> **일급 객체**
> "다른 객체들에 일반적으로 적용 가능한 연산을 모두 지원하는 객체를 가리킨다. 보통 함수에 인자로 넘기기, 수정하기, 변수에 대입하기 와 같은 연산을 지원할 때 일급 객체라고 한다."

고차 함수 는 컨테이너 타입 (Array, Set, Dictionary 등) 에 사용될 수 있고 이들이 가진 각 요소에 대해 동작함

고차 함수를 사용하면 코드를 간결하고 읽기 쉽게 작성할 수 있으며, 코드의 재사용성과 유지보수성을 높일 수 있음

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

## sorted()

> Returns the elements of the sequence, sorted.

```swift
func sorted() -> [Self.Element]
```

요소를 정렬하여 새로운 시퀀스를 반환, 시간복잡도 O(nlogn)

1. sorted()

   ```swift
   let students: Set = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
   let sortedStudents = students.sorted() // 디폴트가 오름차순
   print(sortedStudents) // "["Abena", "Akosua", "Kofi", "Kweku", "Peter"]"
   ```

   <br/>

2. sorted(by)

   ```swift
   // > 내림차순, < 오름차순
   let descendingStudents = students.sorted(by: >)
   print(descendingStudents)
   ```

   <br/>

3. sorted 활용

   - 요소의 특정 구조체나 클래스의 프로퍼티를 기준으로 정렬

     ```swift
     struct Person {
       let name: String
       let age: Int
     }

     let people = [
       Person(name: "k", age: 30),
       Person(name: "h", age: 29),
       Person(name: "lee", age: 40)
     ]

     let sortedPeople = people.sorted { $0.name < $1.name }
     ```

      <br/>

   - 사용자 정의 비교

     ```swift
     let sortedPeople2 = people.sorted {
         if $0.age == $1.age {
             return $0.name < $1.name
         }
         return $0.age < $1.age
     }

     print(sortedPeople2)
     ```

      <br/>

   - Comparable 프로토콜을 따르지 않은 경우
     튜플 같은 타입이나 요소를 비교하기가 애매한 경우에는 Comparable 프로토콜을 따르지 않음

     ```swift
     // 홀수와 짝수로 나누어 정렬하는 예시
     // 숫자가 홀수이면 짝수보다 작은 것으로 간주하고, 짝수이면 홀수보다 큰 것으로 간주하여 정렬
     let number = [3, 1, 4, 1, 5, 9, 2, 6, 5]

     let sortedNumber = number.sorted { num1, num2 in
        if num1 % 2 != num2 % 2 { // 홀수와 짝수를 구분하여 정렬
           return num1 % 2 == 0 // 홀수가 짝수보다 작은 것으로 간주
         } else { return num1 < num2 // 같은 유형의 숫자는 크기에 따라 정렬 }
      }

     print(sortedNumber) // [1, 1, 3, 5, 5, 9, 2, 4, 6]
     ```

     ```swift
     let sortedTuples = tuples.sorted {
         if $0.0 == $1.0 {
          return $0.1 < $1.1 // 같은 숫자일 때 문자열을 기준으로 정렬
         } else {
             return $0.0 < $1.0
         }
      }

     print(sortedTuples) // [(1, "h"), (2, "k"), (3, "l")]
     ```

      <br/>

## forEach(\_ : )

> Calls the given closure on each element in the sequence in the same order as a for-in loop.

```swift
func forEach(_ body: (Self.Element) throws -> Void) rethrows
```

```swift
let numberWords = ["one", "two", "three"]

numberWords.forEach { word in
    print(word)
    // one
    // two
    // three
}
```

## compactMap(\_ : )

> Returns an array containing the non-nil results of calling the given transformation with each element of this sequence.

```swift
func compactMap<ElementOfResult>(_ transform: (Self.Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult]
```

각 요소에 함수를 적용하고, 그 결과가 nil이 아닌 요소들로 이루어진 새로운 시퀀스를 반환

시간 복잡도 O(n)

```swift
let possibleNumbers = ["1", "2", "three", "///4///", "5"]


let mapped: [Int?] = possibleNumbers.map { str in Int(str) }
// [1, 2, nil, nil, 5]


let compactMapped: [Int] = possibleNumbers.compactMap { str in Int(str) }
// [1, 2, 5]
```

## flatMap(\_ : )

> Returns an array containing the concatenated results of calling the given transformation with each element of this sequence.

```swift
func flatMap<SegmentOfResult>(_ transform: (Self.Element) throws -> SegmentOfResult) rethrows -> [SegmentOfResult.Element] where SegmentOfResult : Sequence
```

컨테이너의 각 요소를 사용하여 지정된 조건을 호출할 때, 순차적인 결과의 시퀀스를 반환

```swift
let ar = [1, 2, 3, 4]

let mapped = ar.map { Array(repeating: $0, count: $0) }
// [[1], [2, 2], [3, 3, 3], [4, 4, 4, 4]]

let flatMapped = ar.flatMap { Array(repeating: $0, count: $0) }
// [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
```

## 참고

[공식문서 - map](<https://developer.apple.com/documentation/swift/sequence/map(_:)>)

[공식문서 - filter](<https://developer.apple.com/documentation/swift/set/filter(_:)>)

[공식문서 - reduce](<https://developer.apple.com/documentation/swift/sequence/reduce(_:_:)>)

[공식문서 - sorted](<https://developer.apple.com/documentation/swift/sequence/sorted()>)

[공식문서 - forEach](<https://developer.apple.com/documentation/swift/array/foreach(_:)>)

[공식문서 - compactMap](<https://developer.apple.com/documentation/swift/sequence/compactmap(_:)>)

[공식문서 - flatMap](<https://developer.apple.com/documentation/swift/string/flatmap(_:)-i3m9>)
