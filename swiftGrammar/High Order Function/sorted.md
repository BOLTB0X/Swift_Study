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

## 참고

[공식문서 - sorted](<https://developer.apple.com/documentation/swift/sequence/sorted()>)
