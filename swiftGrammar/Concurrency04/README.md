# Task와 TaskGroup

> `Task` : 프로그램의 일환이고 `async` 로 실행할 수 있는 작업의 단위

> 각 `Task` 들은 `child task`들을 갖을 수 있으므로 세부 분류를 위해 `TaskGroup` 사용

`Task` 은 계층 구조로 정렬 되며 작업 그룹의 각 작업에는 동일한 상위 작업이 있으며 각 Task에는 하위 Task가 있을 수 있음. 작은 Task와 `TaskGroup` 간의 명시적인 관계로 인해 이 접근 방식을 **구조적 동시성**이라 함

---

### `Task`

- `Task` : 비동기적으로 실행될 수 있는 작업 단위

- 모든 비동기 코드는 어떤 `Task` 안에서 실행됨

- `Task` 자체는 한 번에 한 가지 일만 하지만, 여러 Task를 만들면 동시에 실행 가능

---

### `async-let` 과 `TaskGroup`

- `async-let`

    - 미리 실행할 비동기 작업 개수를 알고 있을 때 사용

    - 컴파일러가 자동으로 `child task` 생성

    ---

- `TaskGroup`

    - 실행할 작업 개수를 동적으로 정할 수 있고
    
    - 우선순위, 취소, 결과 수집을 더 세밀하게 제어 가능

---

## ex) Task Group

- 부모 Task는 자식 Task가 끝날 때까지 기다림 (자동 `await`)

- 자식 Task에 높은 우선순위를 주면 부모 Task의 우선순위도 올라감

- 부모 Task 취소 시 자식 Task도 전부 취소됨

- Task-local 값이 자식에게 자동 전달됨


*갤러리 사진 목록을 가져오고, 각 사진 다운로드를 자식 Task로 추가*

1. 다운로드가 끝난 순서대로 `show(photo)` 실행 -> 순서는 보장되지 않음

    ```swift
    await withTaskGroup(of: Data.self) { taskGroup in
        let photoNames = await listPhotos(inGallery: "Summer Vacation")
        for name in photoNames {
            taskGroup.addTask { await downloadPhoto(named: name) }
        }
    }
    ```

    ---

2. 결과 반환하는 `TaskGroup` : 모든 `Task` 결과를 배열로 모아서 반환

    ```swift
    let photos = await withTaskGroup(of: Data.self) { group in
        let photoNames = await listPhotos(inGallery: "Summer Vacation")
        for name in photoNames {
            group.addTask {
                return await downloadPhoto(named: name)
            }
        }

        var results: [Data] = []
        for await photo in group {
            results.append(photo)
        }

        return results
    }
    ```

---

## Task Cancellation

> Swift 동시성은 협력적 cancellation model 을 사용합니다.

각 작업은 실행 중 적절한 시점에 취소되었는지 확인하고 취소에 적절하게 대응에야 함, 작업이 수행하는 **task에 따라 취소** 에 대한 대응은 일반적으로 다음 중 하나를 의미

- `CancellationError` 와 같은 오류 발생

- `nil` 또는 empty collection 반환

- 부분적으로 완료된 작업 반환

Swift의 취소는 **협력적(cooperative)** -> 작업이 스스로 취소 여부를 체크해야 함

- **취소 여부 확인 방법**

    1. `Task.checkCancellation()` -> 취소되면 `CancellationError` 던짐

    2. `Task.isCancelled` -> 취소 여부 `Bool` 반환 (유연한 종료 가능)

- `addTaskUnlessCancelled` : 이미 취소되었으면 Task 추가 안 함

```swift
let photos2 = await withTaskGroup(of: Data?.self) { group in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        let added = group.addTaskUnlessCancelled {
            Task.isCancelled ? nil : await downloadPhoto(named: name)
        }
        guard added else { break }
    }

    var results: [Data] = []
    for await photo in group {
        if let photo { results.append(photo) }
    }
    return results
}
```


1. 각 task은 취소 후 새 작업을 시작하는 것을 방지하기 위해 `TaskGroup.addTaskUnlessCancelled(priority:operation:)` 메서드를 사용하여 추가

2. `addTaskUnlessCancelled(priority:operation:)` 를 호출할 때마다 코드는 새 자식 작업이 추가되었는지 확인

3. 그룹이 취소되면 `added` 값은 `false`가 되며, 이 경우 코드는 추가 사진 다운로드를 중단

4. 각 작업은 사진 다운로드를 시작하기 전에 취소 여부를 확인하고 취소된 경우 `nil`을 반환함

5. 마지막에 작업 그룹은 결과를 수집할 때 `nil` 값을 건너뛰고 `nil` 을 반환하여 취소를 처리하면 작업 그룹은 완료된 작업을 삭제하는 대신 취소 시점에 이미 다운로드된 사진이라는 부분적인 결과만 반환할 수 있음

**취소에 대한 즉각적인 알림이 필요한 작업의 경우**

`Task.withTaskCancellationHandler(operation:onCancel:isolation:)` 메서드 사용

```swift
let task = Task {
    await Task.withTaskCancellationHandler {
        for i in 1...5 {
            try? await Task.sleep(nanoseconds: 1_000_000_000) // 1초 대기
            print("작업 진행 중: \(i)")
        }
        print("작업 완료!")
    } onCancel: {
        // 취소 시 실행되는 로직
        print("작업이 취소되었습니다. 리소스 정리 중...")
    }
}
```

---

## Unstructured Concurrency (비구조적 동시성)

> 이전 섹션에서 설명한 구조화된 동시성 접근 방식 외에도 Swift는 비구조화된 동시성도 지원함

> `Task Group` 에 속하는 작업과 달리, 비구조화된 작업은 부모 작업이 없음

> 프로그램에 필요한 방식으로 비구조화된 작업을 관리할 수 있는 완전한 유연성을 제공하지만, 작업의 정확성에 대한 책임도 전적으로 사용자에게 있음

**unstructured task** 를 사용하기 위해선 `Task.init(priority:operation:)` 이니셜라이저를 호출

- `TaskGroup` 에 속하지 않는 `Task`

- `Task { }`: 현재 환경(우선순위, `actor`, `task-local 값`)을 상속받음

- `Task.detached { }`: 정적 메서드 호출 / 완전히 독립 실행 (우선순위, actor 상태 상속 안 함)

```swift
let newPhoto = Data()
let handle = Task {
    return await add(newPhoto, toGalleryNamed: "Spring Adventures")
}
let result = await handle.value
```

---

## 참고

- [공식문서: Concurrency](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Tasks-and-Task-Groups)