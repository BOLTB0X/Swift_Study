# DispatchQueue 와 Task/await 그리고 Combine 의 각각 차이

> 모두 비동기적인 작업을 처리하는 방식

- **DispatchQueue**
  기본적인 스레드 관리와 비동기 작업에 적합하며, 명령형 방식의 비동기 작업을 지원
  <br/>

- **Task/async-await**
  Swift의 최신 비동기 코딩 방식으로, 더 직관적이고 에러 처리도 편함
  <br/>

- **Combine**
  데이터 스트림과 이벤트 기반 반응형 프로그래밍에 적합하며, data를 조합하고 변환하는 작업에 좋음
  <br/>

## DispatchQueue

> **Grand Central Dispatch (GCD)** 의 일부로, Swift에서 비동기 처리를 할 때 가장 기본적으로 사용하는 도구

스레드를 관리하고 작업을 큐에 넣어 비동기로 실행할 수 있도록 도와줌

여러 작업을 병렬로 실행하거나, 백그라운드 작업을 수행하고 메인 스레드에서 UI를 업데이트하는 등의 처리가 가능

- 특징

  - **queue 기반**
    FIFO(First-In, First-Out) 방식으로 작업을 처리
    <br/>

  - **Global 및 Main queue**
    global()은 백그라운드 queue, main은 UI와 상호작용하는 메인 스레드 큐
    <br/>

  - **동시성(concurrency) 제어**
    queue의 async, sync 메서드를 통해 비동기적 또는 동기적으로 실행 가능
    <br/>

- 예시

  ```swift
  print("1")
  DispatchQueue.main.async {
      print("슈우우우우우ㅜ우우웅1")
  }

  print("2")
  DispatchQueue.main.async {
      print("슈우우우우우ㅜ우우웅2")
  }

  print("3")
  DispatchQueue.main.async {
      print("슈우우우우우ㅜ우우웅3")
  }
  //1
  //2
  //3
  //슈우우우우우ㅜ우우웅1
  //슈우우우우우ㅜ우우웅2
  //슈우우우우우ㅜ우우웅3
  ```

  ```swift
  DispatchQueue.global().async {
     // 백그라운드 작업
     // 이 부분에서 특정 무거운 Task를 주로 함

     DispatchQueue.main.async {
         // 메인 스레드에서 UI 업데이트
     }
  }
  ```

  자세한 건 [DispatchQueue Study 참고](https://github.com/BOLTB0X/Swift_Study/blob/main/study/GCDPlayground/dispatchQue.md)
  <br/>

## Task/await

> 최신 Swift에서 도입된 비동기 함수를 처리하는 새로운 방식

> 비동기 함수 내에서 await 키워드를 사용해 비동기 작업을 쉽게 작성할 수 있으며, 코루틴처럼 동작하여 코드 흐름을 더 직관적이고 동기적으로 작성 가능

- 특징

  - **코루틴(Coroutine) 방식**
    비동기 함수가 중단점(await)에서 다른 작업으로 넘어갔다가, 작업이 완료되면 중단된 곳에서 다시 실행
    <br/>
  - **Task 관리**
    Task {}로 비동기 작업을 생성하고 관리 가능
    <br/>

  - **에러 처리**
    try, catch와 결합하여 비동기 작업에서 발생한 에러를 쉽게 처리
    <br/>

  - **CallBack 지옥 방지 가능**
    <br/>

- 예시

  ```swift
  func fetchData() async throws -> Data {
      let url = URL(string: "https://github.com/BOLTB0X")!
      let (data, _) = try await URLSession.shared.data(from: url)
      return data
  }

  Task {
      do {
          let data = try await fetchData()
          print("Data: \(data)")
      } catch {
          print("Error: \(error)")
      }
  }
  ```

  <br/>

## Combine

> 애플에서 제공하는 반응형 프로그래밍(reactive programming) 프레임워크

> Combine은 비동기 데이터 스트림을 처리하는 데 중점을 두고 있으며, 다양한 이벤트 소스를 조합하고 변환 가능

Combine은 **퍼블리셔(publisher)** 와 **구독자(subscriber)** 개념을 기반으로 동작하며, 데이터 스트림이 업데이트될 때마다 자동으로 반응

- 특징

  - **데이터 스트림**
    Combine에서는 data를 스트림 형태로 처리. data를 퍼블리시하고, 구독자는 이 data를 받아 처리
    <br/>

  - **Publisher & Subscriber**
    Publisher는 data를 발행하고, Subscriber는 이를 받아서 처리
    <br/>

  - **연산자(operator)**
    다양한 연산자(map, filter, flatMap 등)를 사용해 data 스트림을 변환 가능
    <br/>

자세한건 [Combine Study 참고](https://github.com/BOLTB0X/Combine)

## 정리

|                      | **DispatchQueue**                              | **Task/async-await**                              | **Combine**                                          |
| -------------------- | ---------------------------------------------- | ------------------------------------------------- | ---------------------------------------------------- |
| **비동기 처리 방식** | 스레드 및 큐 기반, 비동기 및 동기 작업 처리    | 코루틴 기반, 비동기 함수를 직관적 코드로 작성     | 반응형 프로그래밍, 데이터 스트림을 구독하고 처리     |
| **코드 흐름**        | 명령형(Imperative), 큐에 작업 추가 후 처리     | 비동기 작업을 동기 코드처럼 작성 가능             | 선언형(Declarative), 데이터 스트림에 반응            |
| **에러 처리**        | 에러 처리를 직접 작성 (`do-catch` 구조 없음)   | `try-await`를 사용해 비동기 작업에서 에러 처리    | `sink` 등에서 에러를 구독하며 처리 가능              |
| **사용 목적**        | 동시성 작업 제어, UI 업데이트와 병렬 작업      | 비동기 함수 처리, 더 직관적인 비동기 코드 작성    | 비동기 데이터 스트림 처리, 복잡한 데이터 변환        |
| **실행 제어**        | 동기 및 비동기 방식으로 작업을 명시적으로 제어 | 자동으로 비동기 흐름 제어, 작업 중단 및 재개 가능 | 퍼블리셔와 구독자 패턴으로 데이터 흐름을 반응형 제어 |

## 참고

- [공식문서 - dispatchqueue](https://developer.apple.com/documentation/dispatch/dispatchqueue)

- [공식문서 - dispatchqueue - main](https://developer.apple.com/documentation/dispatch/dispatchqueue/1781006-main)

- [공식문서 - dispatchqueue - global](https://developer.apple.com/documentation/dispatch/dispatchqueue/2300077-global)

- [공식문서 - DispatchQoS.QoSClass](https://developer.apple.com/documentation/dispatch/dispatchqos/qosclass)

- [블로그 참고 - seons](https://seons-dev.tistory.com/215)

- [블로그 참고 - zeddios](https://zeddios.tistory.com/972)

- [블로그 참고 - furang](https://furang-note.tistory.com/37)

- [블로그 참고 - 김종권 iOS](https://ios-development.tistory.com/958)
