# Concurrency: 동시성

> Swift는 구조화된 방식으로 비동기 및 병렬 코드를 작성할 수 있도록 기본적으로 지원

> **병렬 코드** 는 여러 코드가 동시에 실행되는 것을 의미

> 병렬 및 비동기 코드를 사용하는 프로그램은 한 번에 여러 작업을 수행하며, 외부 시스템을 기다리는 작업은 일시 중단

> 비동기 및 병렬 코드의 일반적인 조합을 지칭하기 위해 동시성이라는 용어를 사용함


**같은 시간 내에 다수의 작업이 실행되도록 하는 프로그래밍**

- 병렬 또는 비동기 코드를 사용하면 스케줄링 유연성이 높아지지만, 복잡성이 증가한다는 단점도 존재

- 동시성 코드를 작성할 때는 어떤 코드가 동시에 실행될지 미리 알 수 없고, 코드 실행 순서를 항상 알 수 있는 것도 아님

- 동시 코드에서 흔히 발생하는 문제는 여러 코드가 공유되는 변경 가능한 상태에 접근하려고 할 때 발생하는데, 이를 **데이터 경합(data race)** 이라고 함

 - 동시성 지원을 사용하면 **Swift** 가 **데이터 경합(data race)** 을 감지하고 방지하며, 대부분의 데이터 경합은 컴파일 타임 오류를 발생시킴
 
 - 일부 **데이터 경합(data race)** 은 코드가 실행될 때까지 감지할 수 없으며, 이러한  **데이터 경합(data race)** 은 코드 실행을 종료시킴

   - **actor** 와 **isolation** 를 사용하여 데이터 경합을 방지할 수 있습니다.

---

## Intro

**싱글 코어** 에서 **멀티스레드를 동작시키기 위한 방식** 으로, 멀티 태스킹을 위해 여러 개의 스레드가 '번갈아가면서' 실행되는 성질


---

## Intro in Swift 문법

> Swift 5.5 이전에는 GCD와 **completion handler** 등을 사용해 비동기 프로그래밍을 진행

***GCD** 와 **completion handler** 에 대한 기초 설명은 밑에 링크 참조*

- [Thread](https://github.com/BOLTB0X/SwiftUI/tree/main/study/Thread)

- [DispatchQueue](https://github.com/BOLTB0X/SwiftUI/blob/main/study/GCDPlayground/dispatchQue.md)

- [Sync 와 Async 개념](https://github.com/BOLTB0X/SwiftUI/blob/main/study/GCDPlayground/syncAsync2.md)


<details>

<summary>completion handler 방식의 한계 </summary>

### 기존 방식의 문제점

> 기존 방식 **GCD** 와 **completion handler** 방식으로 코딩을 하다보면 몇가지 문제가 발생

*예를 들어 판매자가 택배를 보내는 과정을 나타내보면*

```
1. 물건 제작
2. 물건 포장
3. 물건 발송
```

```swift
// parcelDelivery
func parcelDelivery(completion: @escaping ((PavingParcel) -> Void)) {
    makeParcel { parcel in // 1. 물건 제작
      self.paveParcel(parcel: parcel) { pavingParcel in // 2. 물건 포장
         self.sendParcel(parcel: pavingParcel, destination: city) { finalParcel in // 3. 물건 발송
            completion(pavingParcel)
         }
      }
    }
}
```

1. **복잡성 증가**

   - 복잡한 비동기 작업의 경우

   - **GCD** 를 사용하면 코드가 복잡해짐 여러 개의 큐를 다루거나 **동시성 문제를 처리하는 것은 어려움**

2. **Deadlock**

   - 잘못된 큐 사용으로 인해 데드락이 발생할 수도 있음

3. **클로저에 대한 비동기 콜백 지옥**

   - 비동기 작업을 여러 단계로 나눠 콜백으로 처리할 경우
   
   - **콜백이 중첩되어** 코드의 가독성과 유지보수 난이도 증가

4. **메모리 관리**

   - **GCD** 로 작업을 비동기적으로 실행할 때, 강한 순환 참조로 인해 메모리 누수가 발생

5. **참조 사이클 발생 가능성**
   
   - `self property` 에 접근할 때, 어떤 스레드에서 접근하게 될지 생각하기 힘들고 **참조 사이클 발생 가능성을 고려해야함**

---

</details>


<details>
<summary> 동시성의 등장 </summary>

### `async` , `await` 키워드 등장

> **Swift 5.5** 에 도입 된 `async`, `await` 문법으로 위 문제 사항을 보완이 가능

- `async` : 비동기 함수임을 나타내는 키워드

- `await` : `async` 키워드가 표시된 메소드나 함수의 리턴을 기다림

   즉 `async` 함수는 비동기적으로 동작할 수 있고, `await` 키워드를 사용해 **비동기 함수의 결과를 대기**


```swift
func parcelDelivery() async throws -> PavingParcel {
   let parcel = try await makeParcel() // 물건 제작
   let Parcel = try await paveParcel() // 물건 포장
   let pavingParcel = try await sendParcel(parcel: Parcel, destination: city) // 물건 발송

   return pavingParcel
}
```

1. **가독성 해결**

2. **참조 사이클 우려 저하**

3. **디버깅이 쉬어짐**

</details>

---

## 참고

- [바삭한 신입들의 동시성 이야기 - Swift편](https://tech.devsisters.com/posts/crunchy-concurrency-swift/)

- [공식문서: Concurrency](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Calling-Asynchronous-Functions-in-Parallel)

- [Swift concurrency: Behind the scenes](https://developer.apple.com/videos/play/wwdc2021/10254/)

- [김종권의 iOS](https://ios-development.tistory.com/589)
