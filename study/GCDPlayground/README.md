# GCD(Grand Central Dispatch)

> 애플이 macOS 및 iOS OS에서 멀티 스레딩을 위한 저수준 API로 제공해주는 프레임워크

애플은 Multi Threading을 위하여 2가지( NSOperation, GCD) API를 제공

## NSOperation

> NSOperation은 Objective-C 기반의 고수준 API, 다양한 작업을 나타내는 추상 클래스

NSOperation 클래스를 직접 사용하기보다는 일반적으로 NSOperationQueue와 함께 사용

NSOperationQueue를 사용하면 여러 작업을 순차적으로 또는 병렬로 실행(NSOperationQueue는 Concurrent Queue로 동작)

작업의 실행을 취소하거나 작업 간의 의존성을 관리

- **추상 클래스**
  NSOperation은 추상 클래스이므로 직접 인스턴스로 사용 X , 이 클래스를 서브클래싱하여 사용자 정의를 구현해야 합
  <br/>

- **상태 관리**
  NSOperation은 Task의 상태를 준비(Pending), 실행(Executing), 완료(Finished) 등 관리
  <br/>

- **작업의 취소**
  NSOperation은 Task를 취소할 수 있는 기능이 존재, Task가 취소된 상태일 때는 추가적인 실행이 중지가 됌

## GCD

> C언어 기반의 저수준 API, C언어 기반이기 때문에 NSOperation보다 가볍고 성능면에서 좋음

Block(Closure)로 구현되어 있어 코드 가독성 좋음

작업 취소, KVO, 재사용 등은 제공 X -> 직접 정의가 필요

Dispatch Queue 을 사용하여 Multi Threading 지원 -> GCD 에 Task 만 전달하면 알아서 Thread 배정을 해서 실행시켜주는 것

- [DispatchQueue](https://github.com/BOLTB0X/Swift_Study/blob/main/study/GCDPlayground/dispatchQue.md)
  <br/>

- [sync(동기)와 Async(비동기)](https://github.com/BOLTB0X/Swift_Study/blob/main/study/GCDPlayground/syncAsync2.md)
