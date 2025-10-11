# `for - in` vs `forEach`

- `for-in` : 제어문(`break` / `continue` / `return`), `await`, 복잡한 로직, 성능/디버깅 제어가 필요할 때 사용

- `forEach` : 값에 대해 간단한 클로저로 **한 줄 처리** 같은 것에 쓰기 좋음, 하지만 중단(`break` / `continue`)이 불가능하고 `return` 은 바깥 스코프를 빠져나가지 못함

## 문법과 기본 동작 비교

### `for - in`

```swift
for x in arr {
    print(x)
}
```

- 루프 변수 `x` 는 각 반복마다 새로운 값으로 바인딩

- `break` , `continue` , `return` 사용 가능.

- `await` / `try` 등 자유롭게 쓸 수 있음

### `forEach`

```swift
arr.forEach { x in
    print(x)
}
```

- `forEach` 는 클로저를 받고 각 요소에 대해 그 클로저를 호출

- 내부 구현은 `Sequence.forEach(_:)` 메서드(사실상 함수 호출 반복)

- `break` / `continue` 사용 불가능

- `return` 은 클로저에서의 반환일 뿐, 바깥 함수/루프를 빠져나가는 것은 불가능

---

## 제어 흐름 차이 — `break` / `continue` / `return`

```swift
func testForIn() {
    for x in arr {
        if x == 2 { return print("returned from function") } // 함수 종료
    }
    print("after for-in") // 실행 안됨
}

func testForEach() {
    arr.forEach { x in
        if x == 2 { return print("returned from closure") } // 클로저만 반환
    }
    print("after forEach") // 여전히 실행됨
}

testForIn()   // returned from function
testForEach() // returned from closure  / after forEach
```

`forEach` 내부의 `return`은 클로저의 반환일 뿐, 바깥 함수나 루프를 종료시키지 못함

---

## 예외(throwing) 처리

```swift
func mayThrow(_ x: Int) throws { if x == 2 { throw NSError() } }

do {
    try arr.forEach { try mayThrow($0) }
} catch {
    print("caught")
}
```

- `forEach`의 시그니처는 `Sequence.forEach(_: ) rethrows` 이므로 클로저가 `throwing`이면 호출부에서 `try` 필요

- `for-in` 도 당연히 `try`로 `try-catch` 가능

- 둘 다 가능하긴 하지만 `for-in`이 더 직관적(중단 필요 시)

---

## `async` / `await` 차이

```swift
for x in arr {
    let r = await doSomethingAsync(x)
}
```

- `for-in` 은 `async` 컨텍스트 내에서 `await` 사용 가능

```swift
arr.forEach { x in
    let r = await doSomethingAsync(x) // 컴파일 오류 (closure isn't async)
}
```

- `forEach`의 클로저는 `async`를 기대하지 않으므로 일반적으로 `await` 를 바로 쓸 수 없음

---

## 컬렉션 변형 & 가변성

- 루프 변수 자체를 재할당하려는 경우:

    swift에서 루프 변수는 상수처럼 취급되므로 직접 재할당 불가능(대신 인덱스 통해 컬렉션을 수정)

- 컬렉션 원소를 안전하게 수정하려면 인덱스를 사용을 함

---

## 추천 가이드

- `for-in`

    - 루프 도중 중단(`break`/`continue`/`return`) 이 필요할 때

    - `await`를 사용해야 할 때

    - 예외를 던지고 즉시 멈추거나 처리해야 할 때

    - 루프 내부가 복잡하거나 디버깅이 필요한 경우

- `forEach`

    - 각 요소에 대해 단순한 것(로그, `append` 등) 만 할 때

    - 코드가 간단해서 가독성이 좋아질 때

---

## 참고

- [위키독스 - for](https://wikidocs.net/246337)

- [개발자소들이 - for - in / forEach 제대로 알고 쓰기](https://babbab2.tistory.com/95)

- [아리의 iOS 탐구 생활 - for each 와 for in의 차이점](https://leeari95.tistory.com/11)