# Concurrency: 동시성

> 같은 시간 내에 다수의 작업이 실행되도록 하는 프로그래밍
> <br/>

## Intro

Swift 5.5 이전에는 GCD와 completion handler등을 사용해 비동기 프로그래밍을 했었음
<br/>

GCD와 completion handler에 대한 기초 설명은 밑에 링크 참조
<br/>

- [Thread](https://github.com/BOLTB0X/SwiftUI/tree/main/study/Thread)

- [DispatchQueue](https://github.com/BOLTB0X/SwiftUI/blob/main/study/GCDPlayground/dispatchQue.md)

- [Async,Sync](https://github.com/BOLTB0X/SwiftUI/blob/main/study/GCDPlayground/syncAsync2.md)

기존 방식 GCD와 completion handler 방식으로 코딩을 하다보면 몇가지 문제가 발생
<br/>

```swift
// completionHandlerFunction
func completionHandlerFunction(completion: @escaping (Int?) -> Void) {
    var cnt:Int = 0
    DispatchQueue.global().async {
        // 비동기 작업을 수행하는 부분
        // 숫자 카운트
        cnt += 1

        DispatchQueue.main.async {
            completion(cnt)
        }
    }
}
```

1. **복잡성 증가**
   <br/>
   복잡한 비동기 작업의 경우
   <br/>
   GCD를 사용하면 코드가 복잡해짐 여러 개의 큐를 다루거나 동시성 문제를 처리하는 것은 어려움
   <br/>

2. **Deadlock**
   <br/>
   잘못된 큐 사용으로 인해 데드락이 발생할 수도 있음
   <br/>

3. **클로저에 대한 비동기 콜백 지옥**
   <br/>
   비동기 작업을 여러 단계로 나눠 콜백으로 처리할 경우 콜백이 중첩되어 코드의 가독성과 유지보수 난이도 증가
   <br/>

4. **메모리 관리**
   <br/>
   GCD로 작업을 비동기적으로 실행할 때, 강한 순환 참조로 인해 메모리 누수가 발생
   <br/>

5. **디버깅 어려움**
   <br/>
   여러 개의 큐를 사용하고 다른 스레드에서 작업이 실행되기 때문에 디버깅이 난해함
   <br/>

6. **retain cycle(참조 사이클) 발생 가능성**
   <br/>
   만약 코드 내부에서 self 키워드에 접근해야 한다면 retain cycle(참조 사이클) 발생 가능성을 고려해야함
   <br/>
   그렇다고 무분별한 [weak self]의 사용은 런타임 오버헤드를 발생시킬 수도 있고, nil을 체크해야 하는 수고를 거쳐야 함
   <br/>
   guard let 문법을 사용한다면 self가 nil 일 때 특정 코드들을 건너뛰게 되는 상황도 발생 가능
   <br/>

## async, await

> async: 비동기 함수임을 나타내는 키워드
> <br/>
> await: async 키워드가 표시된 메소드나 함수의 리턴을 기다린다. 즉, async 함수는 비동기적으로 동작할 수 있고, await 키워드를 사용해 비동기 함수의 결과를 대기할 수 있습니다
> <br/>

```swift
// async/await Function
func asyncAwaitFunction() async -> Int {
    var cnt: Int = 0

    await withUnsafeContinuation { continuation in
        DispatchQueue.global().async {
            // 비동기 작업을 수행하는 부분
            // 숫자 카운트
            cnt += 1

            // 비동기 작업이 끝났음을 continuation에 알림
            continuation.resume(returning: cnt)
        }
    }

    return cnt
}
```

<br/>
