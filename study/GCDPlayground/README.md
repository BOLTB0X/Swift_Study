# GCD(Grand Central Dispatch)

> 애플이 macOS 및 iOS OS에서 멀티 스레딩을 위한 저수준 API로 제공해주는 프레임워크

애플은 [Multi Threading](https://github.com/BOLTB0X/Swift_Study/blob/main/study/OS/MultiProcessThread.md#%EB%A9%80%ED%8B%B0-%EC%8A%A4%EB%A0%88%EB%93%9Cmulti-thread)을 위하여 2가지(`NSOperation`, `GCD`) API를 제공

### iOS에서 GCD와 스레드의 역할

>iOS 앱은 기본적으로 싱글 프로세스 구조에서 동작하며,<br/>이 프로세스 내에는 **여러 개의 Thread** 가 존재

가장 중요한 스레드는 바로 **Main Thread(UI Thread)** 로,<br/>
모든 **UI 업데이트, 이벤트 처리** 가 이 스레드에서 일어남

- 메인 스레드는 앱의 *“UI”* 과 직결

- **무거운 연산(네트워크, 이미지 처리 등)** 은 별도의 백그라운드 스레드에서 수행해야 함

즉 **GCD(Grand Central Dispatch)** 가 스레드 관리를 대신 수행해주는 것

---

## NSOperation

> `NSOperation` : Objective-C 기반의 고수준 API, 다양한 작업을 나타내는 추상 클래스

1. `NSOperation` 클래스를 직접 사용하기보다는 일반적으로 `NSOperationQueue` 와 함께 사용

   - `NSOperationQueue` 를 사용하면 여러 작업을 **순차적으로** 또는 **병렬로 실행(`NSOperationQueue` 는 Concurrent Queue로 동작)**

   - 작업의 실행을 취소하거나 작업 간의 **의존성** 을 관리

      ---

2. **추상 클래스**

   - `NSOperation` 은 추상 클래스이므로 직접 인스턴스로 사용 X
  
   - 이 클래스를 서브클래싱하여 사용자 정의를 구현해야 함
   
      ---

3. **상태 관리**

    - `Task` 의 상태를 **준비(Pending), 실행(Executing), 완료(Finished)** 등 관리

      ---

4. **작업의 취소**

    - `Task` 를 취소할 수 있는 기능이 존재
  
    - `Task` 가 취소된 상태일 때는 추가적인 실행이 중지가 됌

---

## 왜 GCD를 알아야 하는가

1. **성능 최적화 (Responsiveness)**

   - 메인 스레드에서 시간이 오래 걸리는 작업(예: 네트워크 요청, 대용량 이미지 처리)을 수행하면,<br/>
  UI가 멈추거나 터치가 먹히지 않는 **“앱 멈춤 현상”** 이 발생할수 있음

   - GCD를 통해 **백그라운드 큐** 에서 연산을 수행하고, 결과만 **메인 큐에서 UI에 반영하면**
  앱이 부드럽고 반응성 있게 동작 가능

2. **시스템 효율성**

   - iOS는 내부적으로 스레드 풀(Thread Pool) 을 관리하지만, 직접 스레드를 생성하면 메모리 낭비 및 오버헤드가 커짐

   - GCD는 시스템 수준에서 최적화된 **디스패치 큐(Dispatch Queue)** 를 통해
  적절한 **스레드에 작업을 효율적으로 배분해 줌**

3. **클로저(Closure) 기반**

   - GCD는 클로저(Closure) 기반으로 작성

    ```swift
    DispatchQueue.global().async {
      // 백그라운드 작업
      let data = loadImage()
      DispatchQueue.main.async {
          // UI 업데이트
          imageView.image = data
      }
    }
    ```
    
     - 복잡한 스레드 생성, 관리, 동기화 코드를 직접 작성할 필요가 없음

4. **안정성 (Thread-Safety)**

   - 동시에 접근하는 자원(ex: Shared Data)을 안전하게 다루기 위해

   - GCD는 **Serial Queue** 를 통한 동기화 메커니즘을 제공

   - 즉, 락(lock)을 직접 관리하지 않아도 순차적으로 안전하게 실행 가능

## GCD가 실제로 하는 일 (스레드와의 관계)

| 구분                 | 역할                                  | ex          |
| ------------------ | ----------------------------------- | ----------- |
| **Thread**         | 작업을 수행하는 실제 일꾼                      | *“주방의 요리사”*   |
| **Dispatch Queue** | 일꾼에게 일을 배분하는 관리인                    | *“주방장”*       |
| **GCD**            | 주방 전체를 관리하는 시스템 (요리사 고용, 배치, 효율 조정) | *“식당 운영 시스템”* |

- Thread: 실제 일을 하는 단위

- GCD: 어떤 스레드가 어떤 일을 할지 스케줄링하고 관리하는 시스템 레벨 도구

---

## Swift Concurrency (`async`/`await`)와의 관계

> `async/await` 은 내부적으로 GCD의 큐와 스케줄러를 이용해, 비동기 흐름을 언어 차원에서 더 안전하고 직관적으로 표현한 것

- **GCD** : C 기반의 저수준 API

- **Swift Concurrency (`async`/`await`)** : GCD 위에서 돌아가는 고수준 모델

`async`/`await`은 완전히 새로운 스레드 시스템이 아니라,<br/>
**GCD(DispatchQueue)** 위에 만들어진 언어 차원의 고수준 추상화

1. **Swift Concurrency는 GCD 위에서 동작**

   ```swift
   DispatchQueue.global().async {
       // 백그라운드 실행
   }
   ```

   ```swift
   Task.detached {
       // 백그라운드 실행
   }
   ```

   - 위 2개의 코드들은 **내부적으로 모두 GCD의 스레드 풀을 이용**

   - 단지 `Task` 는 Swift 런타임이 알아서 스케줄링·취소·우선순위 관리까지 대신 해주는 것

      ---

2. `async`/`await` 으로 대체 가능한 경우

   | 시나리오            | GCD                                          | Swift Concurrency 대체                               |
   | --------------- | ---------------------------------------------- | -------------------------------------------------- |
   | 비동기 네트워크 호출     | `DispatchQueue.global().async { fetchData() }` | `let data = await fetchData()`                     |
   | UI 업데이트         | `DispatchQueue.main.async { updateUI() }`      | `@MainActor func updateUI()`                       |
   | 여러 비동기 작업 병렬 처리 | `DispatchGroup`                                | `async let result1 = ...; async let result2 = ...` |
   | 작업 취소           | 직접 관리해야 함                                      | `Task { ... }` 내부에서 자동 취소 가능                       |

   - **GCD** : 스레드 관리, 큐 선택, 클로저 블록 작성

   - `async`/`await` : 언어 차원에서 구조화된 동시성 (코드 가독성 + 안정성 up)

      ---

## [DispatchQueue](https://github.com/BOLTB0X/Swift_Study/blob/main/study/GCDPlayground/dispatchQue.md)

## [sync(동기)와 Async(비동기) 개념](https://github.com/BOLTB0X/Swift_Study/blob/main/study/GCDPlayground/syncAsync2.md)

## 참고

- [블로그 참고 - Swift) GCD (Grand Central Dispatch)(limjs-dev)](https://limjs-dev.tistory.com/107)

- [블로그 참고 - 기초문법 [DispatchQueue란?] (GCD : Grand Central Dispatch)(서근)](https://seons-dev.tistory.com/215)

- [블로그 참고 - Swift Concurrency와 GCD(Esiwon)](https://siwon-code.tistory.com/36)