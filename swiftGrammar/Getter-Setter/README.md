# get, set, willSet, didSet

프로퍼티의 값에 접근하고 변경하는 방식 or 변경 전후에 특정 동작을 수행할 수 있도록 하는 기능

- **get**: 값을 반환하는 역할
- **set**: 값을 변경할 때 실행되며, 변경된 값을 처리

<br/>

- **willSet**: 값이 설정되기 직전에 호출, 새 값을 확인 가능
- **didSet**: 값이 설정된 직후에 호출, 변경 전 값을 확인 가능

<br/>

## get And set

> 연산 프로퍼티에서 값을 가져오거나 설정할 때 사용

- 연산 프로퍼티는 값 저장소가 없으며, 값을 계산하거나 반환하기 위해 get과 set 키워드를 사용
  <br/>

- get은 값을 가져오는 역할, set은 값을 설정할 때 실행
  <br/>

- 예시

  ```swift
  class Rectangle {
      var width: Double = 0.0
      var height: Double = 0.0

      var area: Double {
          get {
              return width * height
          }

          set(newArea) {
              let ratio = newArea / (width * height)
              width *= ratio
              height *= ratio
          }
      }
  }

  let rect = Rectangle()
  rect.width = 5.0
  rect.height = 4.0
  print(rect.area)
  // 20.0

  rect.area = 40.0
  print(rect.width)
  // 10.0
  ```

  - **get**: 값 반환

  - **set**: area 값을 설정 -> 가로와 세로의 비율을 맞춤
    <br/>

## willSet And didSet

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

let stepCounter = StepCounter()
stepCounter.totalSteps = 100
//totalSteps: 100 설정
//100 steps 더 해짐

stepCounter.totalSteps = 150
//totalSteps: 150 설정
//50 steps 더 해짐
```

## 참고

- [블로그 참조 - 개발자소들이](https://babbab2.tistory.com/118?category=828998)

- [블로그 참조 - zeddios](https://zeddios.tistory.com/243)
