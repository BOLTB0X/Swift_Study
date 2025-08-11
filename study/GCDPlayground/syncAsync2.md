## sync(동기)와 Async(비동기)

## Sync: synchronously(동기)

> 작업이 다 끝난 다음에만 현제의 Queue에게 컨트롤을 넘김.

즉 현재의 Queue는 block상태가 되며 그 작업이 끝날 때까지 기다려야 함

```swift
DispatchQueue.global(qos: .background).sync {
    for item in 1...10 {
        print("sync : \(item)")
    }
}

for item in 50...60 {
    print(item)
}
// sync : 1
//sync : 2
//sync : 3
//sync : 4
//sync : 5
//sync : 6
//sync : 7
//sync : 8
//sync : 9
//sync : 10
//50
//51
//52
//53
//54
//55
//56
//57
//58
//59
//60
```

즉 순차적으로 실행되는 것을 확인 가능
<br/>

## Async: Asynchronous(비동기)

> 작업을 수행할 다른 Queue에게 작업을 넘김과 동시에 현재의 Queue에게 컨트롤을 돌려줌

작업이 끝나기 전까지 기다릴 필요 없고 동기와 반대로 block상태가 되지 X

```swift
DispatchQueue.global(qos: .background).async {
    for item in 1...10 {
        print("Async (1) : \(item)")
    }
}

DispatchQueue.global(qos: .background).async {
    for item in 30...40 {
        print("Async (2) : \(item)")
    }
}

for item in 90...100 {
    print(item)
}

//90
//Async (1) : 1
//91
//Async (2) : 30
//92
//Async (1) : 2
//93
//Async (2) : 31
//Async (1) : 3
//94
//Async (1) : 4
//Async (2) : 32
//Async (1) : 5
//95
//Async (2) : 33
//96
//Async (1) : 6
//97
//Async (2) : 34
//98
//Async (1) : 7
//99
//Async (2) : 35
//100
//Async (2) : 36
//Async (1) : 8
//Async (2) : 37
//Async (1) : 9
//Async (2) : 38
//Async (2) : 39
//Async (1) : 10
//Async (2) : 40
```

sync와 다르게 async는 동시에 처리되어 섞여서 `print` 됌

```swift
DispatchQueue.global(qos: .userInteractive).async {
    for item in 1...10 {
        print("Async (1) : \(item)")
    }
}

DispatchQueue.global(qos: .background).async {
    for item in 30...40 {
        print("Async (2) : \(item)")
    }
}

for item in 90...100 {
    print(item)
}

// sync : 1
//sync : 2
//sync : 3
//sync : 4
//sync : 5
//sync : 6
//sync : 7
//sync : 8
//sync : 9
//sync : 10
//50
//51
//52
//53
//54
//55
//56
//57
//58
//59
//60

print("----------------------------------")

DispatchQueue.global(qos: .background).async {
    for item in 1...10 {
        print("Async (1) : \(item)")
    }
}

DispatchQueue.global(qos: .background).async {
    for item in 30...40 {
        print("Async (2) : \(item)")
    }
}

for item in 90...100 {
    print(item)
}

//90
//Async (1) : 1
//91
//Async (2) : 30
//92
//Async (1) : 2
//93
//Async (2) : 31
//Async (1) : 3
//94
//Async (1) : 4
//Async (2) : 32
//Async (1) : 5
//95
//Async (2) : 33
//96
//Async (1) : 6
//97
//Async (2) : 34
//98
//Async (1) : 7
//99
//Async (2) : 35
//100
//Async (2) : 36
//Async (1) : 8
//Async (2) : 37
//Async (1) : 9
//Async (2) : 38
//Async (2) : 39
//Async (1) : 10
//Async (2) : 40
//슈우우우우우ㅜ우우웅1
//슈우우우우우ㅜ우우웅2
//슈우우우우우ㅜ우우웅3

print("--------------------------------------------------")
DispatchQueue.global(qos: .userInteractive).async {
    for item in 1...10 {
        print("Async (1) : \(item)")
    }
}

DispatchQueue.global(qos: .background).async {
    for item in 30...40 {
        print("Async (2) : \(item)")
    }
}

for item in 90...100 {
    print(item)
}

//90
//Async (1) : 1
//91
//Async (1) : 2
//92
//Async (1) : 3
//93
//Async (1) : 4
//94
//Async (1) : 5
//95
//Async (1) : 6
//Async (1) : 7
//96
//97
//Async (1) : 8
//98
//99
//Async (1) : 9
//100
//Async (1) : 10
//Async (2) : 30
//Async (2) : 31
//Async (2) : 32
//Async (2) : 33
//Async (2) : 34
//Async (2) : 35
//Async (2) : 36
//Async (2) : 37
//Async (2) : 38
//Async (2) : 39
//Async (2) : 40
```

두번째 코드에서 `qos` 중 우선순위를 수정해서 실행해보면 우선순위가 높은 `DispatchQueue`가 먼저 실행되는 것을 알 수있음

**_이를 정리하면_**

- `DispatchQueue`

  **Serial(순차적)** / **Concurrent(동시적)** 으로 나뉘며 각각 sync/async로 실행

- `Main Queue`

  Main Thread에서 돌아가는 Serial Queue, sync로 실행하면 데드락 발생하므로 금지

- `Global Queue`
  
  qos에 따라서 우선순위 부여할 수 있는 Concurrent Queue
  

- **Custom Queue**

  default는 Serial이며 attributes를 이용하여 Concurrent로 변경 가능
  
---

## 참고

- [공식문서 - dispatchqueue](https://developer.apple.com/documentation/dispatch/dispatchqueue)

- [공식문서 - os_dispatch_queue_concurrent](https://developer.apple.com/documentation/dispatch/os_dispatch_queue_concurrent)

- [블로그 참고 - [DispatchQueue란?] (GCD : Grand Central Dispatch)(서근)](https://seons-dev.tistory.com/215)

- [블로그 참고 - Combine (3) - Scheduler(zeddios)](https://zeddios.tistory.com/972)

- [블로그 참고 - DispatchQueue - Serial, Concurrent](https://furang-note.tistory.com/37)
