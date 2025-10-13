# Singleton Pattern vs `static` 방식

> 둘 다 전역적으로 접근 가능한 공유 리소스를 만들 수 있음

- **Singleton Pattern** :  인스턴스 생성 시점에 추가적인 로직이 필요하거나 상속을 사용해야 하는 경우에 적합

- `static` : 객체 지향적 특성이 필요 없는 단순 유틸리티 함수나 전역 변수에 사용하기에 더 효율적

---

## 공통점 , 차이점

- **공통점**

    ```swift
    // 싱글톤
    class NetworkManager: @unchecked Sendable {
        static let shared = NetworkManager()
        private init() {}
    }

    // static 방식
    struct MathUtil {
        static func add(_ a: Int, _ b: Int) -> Int {
            return a + b
        }
    }
    ```

    **전역적으로 접근 가능한 공유 리소스를 만들 수 있음**

    ---

- **차이점**

    | 구분      | 싱글톤 (`shared`)                               | static 프로퍼티/메서드                |
    | ------- | -------------------------------------------- | ------------------------------ |
    | 타입      | `class` (참조 타입)                              | `struct`, `class`, `enum` 모두   |
    | 생성 시점   | 처음 접근할 때 생성 (`lazy`)                           | 프로그램 로드 시 생성 (`static`)          |
    | 목적      | 하나뿐인 상태/객체 관리                                | 인스턴스 없이 기능 제공                  |
    | 상태 저장   | 가능 (`mutable`)                                 | 불가능 (`stateless`)                |
    | 테스트 용이성 | 낮음 (상태 공유)                                   | 높음                             |
    | 메모리 | Heap                                   | Stack                             |
    | 대표 사례   | `URLSession.shared`, `UserDefaults.standard` | `Math.random()`, `UIColor.red` |


---

## Singleton Pattern (싱글톤)

> 클래스의 인스턴스가 오직 하나만 존재하도록 보장하는 디자인 패턴

> 그 하나의 인스턴스에 전역적으로 접근해서 사용

```swift
// 싱글톤 ex
class DatabaseManager: @unchecked Sendable {
    static let shared = DatabaseManager()
    private init() {} // 외부에서 생성 금지

    var connected = false

    func connect() {
        connected = true
        print("DB 연결 완료")
    } // connect
} // DatabaseManager
```

```swift
DatabaseManager.shared.connect()
print(DatabaseManager.shared.connected) // true
```

| 항목         | 설명                                            |
| ---------- | --------------------------------------------- |
| **의도**     | 인스턴스를 딱 하나만 만들고, 어디서든 접근할 수 있음                |
| **생성 시점**  | `shared` 접근 시 최초 한 번 생성 (`lazy initialization`) |
| **사용 예시**  | 네트워크 매니저, 데이터 캐시, 세션 관리 등 **“상태를 유지”** 하는 객체       |
| **테스트**    | 상태를 공유하므로 테스트 격리가 어렵다                         |
| **클래스 기반** | `class` 로만 가능 (참조 타입)                         |

---

## `static` 방식

> 인스턴스를 만들지 않고 타입에 직접 속하는 변수나 메서드

> 인스턴스 상태가 없음 (전역적인 유틸리티나 상수에 적합)


```swift
// static ex
struct MathUtil {
    static func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    } // add
    
    static func square(_ n: Int) -> Int {
        return n * n
    } // square

    static let pi = 3.141592
} // MathUtil
```

```swift
print(MathUtil.square(4)) // 16
print(MathUtil.pi) // 3.141592
```

*cf. 프로퍼티가 필요 없고 함수만 선언해야 하는 경우에 주로 `static func` 사용*

| 항목                          | 설명                          |
| --------------------------- | --------------------------- |
| **의도**                      | 독립적인 기능/값을 클래스 인스턴스 없이 제공   |
| **생성 시점**                   | 프로그램 시작 시 메모리에 로드됨 (정적 메모리) |
| **사용 예시**                   | 수학 계산, 문자열 포맷터, 상수 값 등      |
| **테스트**                     | 독립적이므로 테스트 격리 쉬움            |
| **struct/class/enum 모두 가능** | 값 타입도 가능                    |

---


## 주로 사용하는 경우

- 상태가 있는 객체 (공유 자원) -> **Singleton**

    *ex) 네트워크 연결, 사용자 세션, 캐시 관리자*

- 상태가 없는 순수 기능 -> `static`

    *ex) 수학 계산, 문자열 포맷*

---

## 참고

- [블로그 참고 - Singleton vs Static class 차이점(os94)](https://os94.tistory.com/158)

- [블로그 참고 - 프로퍼티가 없는 객체? Singleton Pattern, Static function 그리고 Struct(tmfrlrkvlek)](https://velog.io/@tmfrlrkvlek/%ED%94%84%EB%A1%9C%ED%8D%BC%ED%8B%B0%EA%B0%80-%EC%97%86%EB%8A%94-%EA%B0%9D%EC%B2%B4-Singleton-Pattern-Static-function-%EA%B7%B8%EB%A6%AC%EA%B3%A0-Struct)

- [rudrank - Static property 'shared' is not concurrency-safe because non-'Sendable' type may have shared mutable state](https://rudrank.com/exploring-swift-static-property-shared-is-not-concurrency-safe-because-non-sendable-type-may-have-shared-mutable-state)