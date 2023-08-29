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

예를 들어 판매자가 택배를 보내는 과정을 나타내보면
<br/>

> 1. 물건 제작
> 2. 물건 포장
> 3. 물건 발송

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

<br/>

위 코드를 보면 몇 가지 문제점을 볼 수 있음
<br/>

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

5. **참조 사이클 발생 가능성**
   <br/>
   self property에 접근할 때, 어떤 스레드에서 접근하게 될지 생각하기 힘듬
   <br/>

   참조 사이클 발생 가능성을 고려해야함
   <br/>

## async, await

> async: 비동기 함수임을 나타내는 키워드
> <br/>
> await: async 키워드가 표시된 메소드나 함수의 리턴을 기다린다. 즉, async 함수는 비동기적으로 동작할 수 있고, await 키워드를 사용해 비동기 함수의 결과를 대기
> <br/>

Swift 5.5에 도입 된 async, await 문법으로 위 문제 사항을 보완이 가능
<br/>

```swift
func parcelDelivery() async throws -> PavingParcel {
   let parcel = try await makeParcel() // 물건 제작
   let Parcel = try await paveParcel() // 물건 포장
   let pavingParcel = try await sendParcel(parcel: Parcel, destination: city) // 물건 발송

   return pavingParcel
}
```

<br/>

1. **가독성 해결**
   <br/>

2. **참조 사이클 우려 저하**
   <br/>

3. **디버깅이 쉬어짐**
   <br/>

## suspend(중지)/resume(재개) 필요성

swift의 모든 비동기 함수는 여러 task의 집합으로 이루어짐, 비동기 함수가 다른 비동기 함수를 호출했을 때, 해당 호출 또한 task라고 할 수 있음
<br/>

task는 동기 함수에서 스레드 내 함수 컨텍스트에 해당하는 continuation을 포함하며 continuation은 task가 suspend(중지) 되었을 때 발생하며,
<br/>

resume(재개) 될 때 이를 이용해 suspension point(중지 지점)로 돌아가는 것이 가능
<br/>

## suspend -> resume의 과정

1. await 키워드를 만나면 suspension point로 지정하고 일시정지 (suspend)
   <br/>

2. 스레드의 제어권을 시스템에게 넘겨줌
   <br/>

3. 시스템이 다시 비동기 함수에게 스레드 제어권을 넘겨줌
   <br/>

4. suspension point에서 작업 재개 (resume)
   <br/>

## 병렬로 Async

위에서 설명 했듯이, 비동기 코드가 실행되는 동안 호출자는 다음 코드 줄 실행으로 이동하기 전에 해당 코드가 완료될 때까지 기다림
<br/>

예를 들어 갤러리에서 처음 세 장의 사진을 가져오려면 다음과 같이 downloadPhoto(named:) 함수에 대한 세 번의 호출을 기다릴 수 있음
<br/>

```swift
let firstPhoto = await downloadPhoto(named: photoNames[0])
let secondPhoto = await downloadPhoto(named: photoNames[1])
let thirdPhoto = await downloadPhoto(named: photoNames[2])


let photos = [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
```

<br/>

이런 방식의 비동기에도 단점이 존재. **다운로드가 비동기식이고 진행되는 동안 다른 작업이 수행될 수 있지만 downloadPhoto(named:)에 대한 호출은 한 번에 하나만 실행된다는 점**
<br/>

다음 사진 다운로드가 시작되기 전에 각 사진이 완전히 다운로드되지만 이러한 작업을 기다릴 필요는 없음, 이때 병렬을 적용하면
<br/>

```swift
// 1
async let firstPhoto = downloadPhoto(named: photoNames[0])
async let secondPhoto = downloadPhoto(named: photoNames[1])
async let thirdPhoto = downloadPhoto(named: photoNames[2])


// 2
let photos = await [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
```

1. 세 가지 호출이 모두 이전 호출이 완료될 때까지 기다리지 않고 시작, 사용 가능한 시스템 리소스가 충분하면 동시에 실행할 수 있고 코드가 함수 결과를 기다리기 위해 일시 ​​중지되지 않기 때문에 이러한 함수 호출 중 어느 것도 대기로 표시되지 않음
   <br/>

2. 사진이 정의된 줄까지 실행이 계속 됨 이 시점에서 프로그램은 이러한 비동기 호출의 결과가 필요하므로 세 장의 사진 모두 다운로드가 완료될 때까지 실행을 일시 중지하기 위해 대기를 작성
   <br/>

**병렬로 async함수 호출 방법은 'async let' 키워드로 선언**
<br/>

## Task와 TaskGroup

> Task: 프로그램의 일환이고 async로 실행할 수 있는 작업의 단위
> <br/>
> 각 Task들은 child task들을 갖을 수 있으므로 세부 분류를 위해 TaskGroup 사용
> <br/>

```swift
await withTaskGroup(of: Data.self) { taskGroup in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        taskGroup.addTask { await downloadPhoto(named: name) }
    }
}
```

<br/>

Task는 프로그램의 일부로 비동기적으로 실행될 수 있는 작업 단위, 모든 비동기 코드는 일부 작업의 일부로 실행 됌
<br/>

이전 섹션에서 설명한 async-let 구문은 하위 작업을 생성, 작업 그룹을 생성하고 해당 그룹에 하위 작업을 추가 가능 이를 통해 우선 순위 및 취소를 더 효과적으로 제어할 수 있으며 동적으로 작업 수를 생성할 수 있음
<br/>

Task은 계층 구조로 정렬 되며 작업 그룹의 각 작업에는 동일한 상위 작업이 있으며 각 Task에는 하위 Task가 있을 수 있음. 작Task와 TaskGroup 간의 명시적인 관계로 인해 이 접근 방식을 **구조적 동시성**이라 함
<br/>

## 참고

[바삭한 신입들의 동시성 이야기 - Swift편](https://tech.devsisters.com/posts/crunchy-concurrency-swift/)
<br/>

[swift 공식문서: Concurrency](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Calling-Asynchronous-Functions-in-Parallel)
<br/>

[Swift concurrency: Behind the scenes](https://developer.apple.com/videos/play/wwdc2021/10254/)
<br/>

[김종권의 iOS](https://ios-development.tistory.com/589)
<br/>
