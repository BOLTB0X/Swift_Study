# get, set, willSet, didSet

프로퍼티의 값에 접근하고 변경하는 방식 or 변경 전후에 특정 동작을 수행할 수 있도록 하는 기능

- `get` : 값을 반환하는 역할

- `set`  : 값을 변경할 때 실행되며, 변경된 값을 처리

<br/>

- `willSet` : 값이 설정되기 직전에 호출, 새 값을 확인 가능

- `didSet` : 값이 설정된 직후에 호출, 변경 전 값을 확인 가능

---

## `get` / `set` — 계산 프로퍼티 (Computed properties)

> 연산 프로퍼티에서 값을 가져오거나 설정할 때 사용

```swift
class Rectangle {
    var width: Double = 0.0
    var height: Double = 0.0

    var area: Double {
        get { // area 값 반환
            return width * height
        }
        
        set(newArea) { // area 값을 설정 -> 가로와 세로의 비율을 맞춤
            let ratio = newArea / (width * height)
            width *= ratio
            height *= ratio
        }
    }
    
    var per: Double { 2 * (width + height) }
}
```

- `get` : 값을 가져오는 역할 , `set` : 값을 설정할 때 실행

    - 저장 공간을 갖지 않는 프로퍼티
    
    - `get` 으로 계산해서 반환하고 `set` 으로 값을 받아 다른 저장 프로퍼티를 변경하거나 부수효과를 냄

    ---

- 읽기 전용(Read Only)으로 만들려면 `set` 을 생략

   ```swift
   var per: Double { 2 * (width + height) }
   ```

   ---

- 값 타입(`struct` / `enum` )

    ```swift
    struct Counter {
        var value: Int = 0

        var doubled: Int {
            mutating set {
                value = newValue / 2
            }
            get { value * 2 }
        }
    }
    ```

    - **Setter** 가 `self` 를 변경하려면 `mutating set` 으로 표기해야 할 수 있음

---


## `willSet` / `didSet` — 프로퍼티 옵저버 (Property Observers)

> 저장 프로퍼티의 값이 변경되기 전후에 호출되는 감시자

```swift
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("totalSteps: \(newTotalSteps) 설정")
        }
        didSet {
            if totalSteps > oldValue {
                print("\(totalSteps - oldValue) steps 더 해짐")
            }
        }
    }
}
```

- 값이 바뀌기 직전에 `willSet` 실행(기본 파라미터 이름 `newValue` -> *cf 예시 코드에선* `newTotalSteps`) 

- 값이 바뀐 직후에 `didSet` 실행(기본 파라미터 이름 `oldValue`)

- 옵저버는 초기화 과정에서 프로퍼티에 값을 할당할 때는 호출되지 않음

    - `init` 에서 초기값을 주는 경우 옵저버는 호출 X
    
        ---

- 옵저버는 새 값이 이전 값과 동일하더라도 호출된다 함(값 비교 여부와 관계없이 호출)

- 옵저버 안에서는 `self` 사용 가능(단, 초기화 중이 아닐 때)

- `willSet` / `didSet` 에서 이름 지정:

    ```swift
    var value: Int = 0 {
        willSet(next) {
            print("about to set to \(next)")
        }
        didSet(prev) {
            print("changed from \(prev)")
        }
    }
    ```

---

## 권장 패턴

- `get` / `set`

    다른 저장 프로퍼티에서 파생되는 값(ex. `area`, `celsius`)을 노출하거나, **setter** 에서 자동 변환(ex. *온도변환* )할 때 사용

    ---

- `willSet` / `didSet`

    UI 갱신, 데이터 검증, 부가 상태 갱신(ex. *total 값 재계산* ) 등에 깔끔하게 사용

    ---

- `init` 유의

    옵저버가 실행되는 시점을 잘 이해하고, 초기값 설정 중에 의도치 않은 사이드이펙트가 없게 주의.

---

## 참고

- [블로그 참조 - 개발자소들이](https://babbab2.tistory.com/118?category=828998)

- [블로그 참조 - zeddios](https://zeddios.tistory.com/243)
