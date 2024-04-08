# Main Thread & Global Thread

> Main Thread와 Global Thread는 iOS App의 동작을 구성하는 중요한 요소

## Main Thread

> swift 로 작성된 코드가 Cocoa에서 실행될 때, Main Thread에서 호출

**iOS App의 주요 Task는 Main Thread 에서 실행**

- UI update , event 를 처리하는 주요 Thread
  <br/>
- 사용자의 액션에 따라 UI를 Update하거나, 사용자의 입력에 응답하여 이벤트를 처리하는 Thread
  <br/>

- Main Thread 를 Interface Thread 라고도 함

모든 UI 업데이트는 Main Thread에서 수행되어야 함 (Main Thread에서 긴 Task를 수행하면 UI가 멈추거나 느려질 수 있음)

## Global Thread

> iOS에서의 Framework들은 모두 background에서 구동이 됨

**백그라운드에서 작업을 수행하는 Thread 로, Main Thread 와 별도로 동작함**

- 주로 Dispatch Queue 를 통해 Global Thread를 사용하여 비동기적인 백그라운드 작업을 처리, in iOS
  > **_Dispatch Queue는 Task 를 큐에 추가하고 해당 Task가 실행될 Thread 를 관리하는 GCD(Grand Central Dispatch)의 일부_**

<br/>

- Global Thread CPU와 밀접한 관련있는 Task 나 네트워크 요청 등의 시간이 오래 걸리는 작업을 Main Thread와 분리하여 처리하는 데 사용

background 에서 (ex, REST API 호출 , 음악 재생)실행이 완료 될 때 Task 가 완료 될 시 Main Thread 에게 Delegate , Completion Handler 등을 통하여 알려 통제함

## 참고

[공식문서 - Thread](https://developer.apple.com/documentation/foundation/thread)

[블로그 참고 - 1](https://babbab2.tistory.com/65)

[블로그 참고 - 2](https://woozzang.tistory.com/131)
