# DispatchQueue

> 시스템에서 관리하는 DispatchQueue에 Task를 작성하여 멀티코어 하드웨어에서 코드를 동시에 실행

```swift
class DispatchQueue : DispatchObject
```

GCD에서 작업을 실행하는 FIFO 데이터 구조이자 , Task를 비동기적으로 실행하기 위한 메커니즘을 제공

```
DispatchQueue. Queue의 종류 . sync/async {
    // 클로저(code)가 작업 단위
}
```

**App의 Main Thread 또는 Backgoround Thread에서 순차적(serially) 또는 동시에(concurrently) Task 실행을 관리하는 객체**

## Seral & Concurrent

> dispatchQueue의 동작 방식은 Seral과 Concurrent로 나뉨

1. **Seral**

   - 이전(before) task가 끝나면 다음 task를 순차적(serially)으로 실행하는 직렬 형태의 Queue
     <br/>

   - 한 Task를 실행하고 그 실행이 끝날 때까지 que에 있는 다른 task을 잠시 미루고 있다가 바로 전의 task가 끝나면 실행

2. **Concurrent**

   - 이전(before) task가 끝날 때 까지 기다리지 않고 병렬 형태로 동시에(concurrently) 실행되는 Queue
     <br/>

   - Queue에 있는 작업을 동시에 별도의 Thread를 사용하여 실행

DispatchQueue의 종류는 3가지가 존재

- main Queue
- global Queue
- custom Queue

## Main Queue(Seral)

> The dispatch queue associated with the main thread of the current process.

- main Queue는 task들을 main Thread에 처리
  <br/>

- UIApplicationMain은 자동으로 **Main Queue**를 생성하고 main Thread와 연결함

```swift
class var main: DispatchQueue { get }
```

> iOS 에서 Main Thread는 하나만 존재, main Queue 또한 시스템에 의해 하나만 생성되기 때문에, main Queue를 불어올 때는 인스턴스를 호출하는 방식 이용

task들을 순차적으로 처리하며, 한 번에 1개의 task 만 처리하는 DispatchQueue

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

// 1
// 2
// 3
// 슈우우우우우ㅜ우우웅1
// 슈우우우우우ㅜ우우웅2
// 슈우우우우우ㅜ우우웅3
```

runloop가 끝나야 mainQueue에 들어가 있는 task들이 순차적으로 실행

**_cf. 주의 사항_**

> Main Thread가 Thread-Safe하지 않으므로 Main Queue에는 절대 Sync Task를 추가할 수 없음

## Global Queue(Concurrent)

> Returns the global system queue with the specified quality-of-service class

- Global Queue는 App 전반에 걸쳐 사용할 수 있는 GCD 큐
  <br/>

- Queue의 QoS(Quality of Service) 수준을 지정 가능 -> 이를 통해 각 작업에 대한 우선 순위를 제어할 수 있음

```swift
class func global(qos: DispatchQoS.QoSClass = .default) -> DispatchQueue
```

```swift
var defaultQueue = DispatchQueue.global(qos: .default)
print("1")
defaultQueue.async {
    print("슈우우우우우ㅜ우우웅1")
}
print("2")
defaultQueue.sync {
    print("슈우우우우우ㅜ우우웅2")
}
print("3")
defaultQueue.async {
    print("슈우우우우우ㅜ우우웅3")
}
print("4")
defaultQueue.sync {
    print("슈우우우우우ㅜ우우웅4")
}
```

병렬적으로 동시에 실행이 되긴 하지만 QoS를 통해 우선순위를 결정 가능

우선순위가 높은 작업은 낮은 순위의 작업보다 더 빨리 실행

네트워크 요청이나 파일 처리와 같이 시간이 오래 걸리는 작업들은 Main Queue가 아닌 Background Thread에서 실행을 함 (Global Queue을 이용하여)

### qQoS(Quality of Service)

UI update는 background에서 실행되는 task보다 우선시 되어야하듯 우선순위를 지정이 필요

```swift
DispatchQueue.global(qos: .userInteractive) {}  //Main Queue
DispatchQueue.global(qos: .userInitiated) {}    //유저가 시작한 작업, 유저가 응답을 기다림
DispatchQueue.global(qos: .default) {}          //userInitiated와 utility의 중간
DispatchQueue.global(qos: .utility) {}          //시간이 걸리며 즉각적인 응답이 필요하지 않은 경우
DispatchQueue.global(qos: .background) {}       //눈에 보이지 않는 부분의 작업. 완료 시간 중요X
DispatchQueue.global(qos: .unspecified) {}
```

아래로 갈수록 우선순위가 떨어짐, qos를 지정을 안하면 default로 실행

## Custom Queue

> 사용자가 직접 dispatchQueue를 정의하여 사용 가능

```swift
let concurrentQueue = DispatchQueue.init(label: "myQueue", qos: .background, attributes: .concurrent)
concurrentQueue.async {
    // task
}
```

## Initializers

> Creates a new dispatch queue to which you can submit blocks.

```swift
convenience init(
    label: String,
    qos: DispatchQoS = .unspecified,
    attributes: DispatchQueue.Attributes = [],
    autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency = .inherit,
    target: DispatchQueue? = nil
)
```

- label
  디버깅 도구(예: Instruments, stackshots, crash reports 등)에서 큐를 고유하게 식별하기 위해 사용되는 문자열 label, parameter는 옵셔널
  <br/>

- qos
  우선순위를 결정
  <br/>

- attributes
  queue와 관련된 속성, concurrent attributes을 포함하여 작업을 동시에 실행하는 dispatchQueue를 생성 가능, 이 attributes 생략하면 dispatchQueue는 task가 직렬로 실행 됌
  <br/>

- autoreleaseFrequency
  queue가 스케줄한 블록이 생성한 객체를 자동해제하는 빈도
  <br/>

- target
  블록을 실행할 대상 queue

## 참고

[공식문서 - dispatchqueue](https://developer.apple.com/documentation/dispatch/dispatchqueue)

[공식문서 - dispatchqueue - main](https://developer.apple.com/documentation/dispatch/dispatchqueue/1781006-main)

[공식문서 - dispatchqueue - global](https://developer.apple.com/documentation/dispatch/dispatchqueue/2300077-global)

[공식문서 - DispatchQoS.QoSClass](https://developer.apple.com/documentation/dispatch/dispatchqos/qosclass)

[블로그 참고 - 1](https://seons-dev.tistory.com/215)

[블로그 참고 - 2](https://zeddios.tistory.com/972)

[블로그 참고 -3](https://furang-note.tistory.com/37)
