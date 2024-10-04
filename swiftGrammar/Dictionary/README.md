# Dictionary

> A collection whose elements are key-value pairs.

```swift
@frozen
struct Dictionary<Key, Value> where Key : Hashable
```

- 키-값 쌍을 저장하는 데이터 구조로, 해시 테이블처럼 동작하여 고유한 키를 기반으로 값을 빠르게 찾기 가능
  <br/>

- 다른 언어에서는 **해시(hash)** 로도 불림
  <br/>

- 빈 딕셔너리를 만들 때 **[:]** 사용
  ```swift
  var emptyDict: [String: String] = [:]
  ```

## 접근 / Update / 순회 / 변형

1. 딕셔너리 값 접근 및 설정

   - key를 이용한 서브스크립트 방식으로 접근, Optional 값 반환
     ```swift
     print(responseMessages[200])
     // Optional("OK")
     ```

   <br/>

   - 키가 존재하지 않는 경우 nil 반환

     ```swift
     let httpResponseCodes = [200, 403, 301]
     for code in httpResponseCodes {
        if let message = responseMessages[code] {
            print("Response \(code): \(message)")
        } else {
            print("Unknown response \(code)")
        }
     }
     // Response 200: OK
     // Response 403: Access forbidden
     // Unknown response 301
     ```

    <br/>

   - value를 삭제하려면 value를 nil 로

     ```swift
     responseMessages[500] = nil
     ```

      <br/>

2. 딕셔너리 값 업데이트

   - 딕셔너리에 새로운 키-값 쌍을 추가하거나, 기존 키에 대해 값을 업데이트
     <br/>

   - 예시

     ```swift
     responseMessages[301] = "Moved permanently"
     print(responseMessages[301])
     // Optional("Moved permanently")

     responseMessages[404] = "Not found"
     responseMessages[500] = nil
     print(responseMessages)
     // [403: "Access forbidden", 200: "OK", 404: "Not found", 301: "Moved permanently"]
     ```

<br/>

3. 딕셔너리 for문

   - 딕셔너리의 모든 키-값 쌍을 순회하려면 for-in 루프를 사용
     <br/>

   - 각 쌍은 튜플 형태로 반환
     <br/>

   - 딕셔너리는 순서가 없는 컬렉션이므로, 삽입 순서대로 나오지 않음
     <br/>

   - 예시

     ```swift
     for (k, v) in responseMessages {
         print("\(k) : \(v).")
     }

     //301 : Moved permanently.
     //200 : OK.
     //403 : Access forbidden.
     //404 : Not found.
     ```

4. 딕셔너리의 값 변형

   - 딕셔너리의 값을 직접 변형하려면 키를 통해 값을 수정 가능
     <br/>

   - 예시

     ```swift
     for key in interestingNumbers.keys {
         interestingNumbers[key]?.sort(by: >)
     }


     print(interestingNumbers["primes"]!)
     // [17, 13, 11, 7, 5, 3, 2]
     ```

## 유용한 것들

1. **count**: key 갯수 반환

   ```swift
   print(interestingNumbers.count)
   // 3
   ```

   <br/>

2. 비교: 비교할 딕셔너리들의 key - value가 같아야함

   ```swift
   var dict1 = ["height": 165, "age" : 100]
   var dict2 = ["height": 165, "age" : 100]
   var dict3 = ["Height": 165, "Age" : 100]
   var dict4 = ["name": "sodeul", "address" : "Suwon"]

   print(dict1 == dict2)
   print(dict1 == dict3)
   // print(dict1 == dict4) // Error: inary operator '==' cannot be applied to operands of type '[String : Int]' and '[String : String]'
   ```

   <br/>

```swift
let condition: ((String, Int)) -> Bool = {
    $0.0.contains("h")
}
```

   <br/>

3. **contains(where:)**: 해당 클로저를 만족하는 요소가 하나라도 있을 경우 **true**, 아니면 **false**

   ```swift
   print(dict1.contains(where: condition))
   // true
   ```

   <br/>

4. **first(where: )**: 해당 클로저를 만족하는 첫 번쨰 요소 튜플로 리턴

   ```swift
   print(dict1.first(where: condition))
   // Optional((key: "height", value: 165))
   ```

   <br/>

5. **filter**: 해당 클로저를 만족하는 요소만 모아서 새 딕셔너리로 리턴

   ```swift
   print(dict1.filter(condition))
   // ["height": 165]
   ```

   <br/>

6. **keys**

   ```swift
   for key in responseMessages.keys {
       print(key)
    //    200
    //    301
    //    403
    //    404
   }
   ```

   <br/>

7. **values**

   ```swift
   for value in responseMessages.values {
       print(value)
   //    Ok
   //    Moved permanently
   //    Access forbidden
   }
   ```

   <br/>

8. **removeValueForKey()**

   ```swift
   print(responseMessages)

   responseMessages.removeValue(forKey: 404)

   print(responseMessages)

   //[200: "OK", 301: "Moved permanently", 403: "Access forbidden", 404: "Not found"]
   //[200: "OK", 301: "Moved permanently", 403: "Access forbidden"]
   ```

   <br/>

## 참고

- [공식문서 - Dictionary](https://developer.apple.com/documentation/swift/dictionary)

- [블로그 참조 - 개발자소들이(딕셔너리)](https://babbab2.tistory.com/113)

- [블로그 참조 - dev-log(딕셔너리)](https://dev-dmsgk.tistory.com/19)
