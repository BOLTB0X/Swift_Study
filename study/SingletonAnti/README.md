# Singleton 이 안티패턴이 될 수도 있는 이유

> 전역 상태를 이용하고 테스트의 어려움, 멀티스레드 환경에서의 문제점, 객체 지향 원칙 위배 등으로 인해 안티패턴으로 간주되기도 함


```swift
final class DebugManager: @unchecked Sendable {
    static let shared = DebugManager()

    func log(_ message: String) {
        print("[LOG]", message)
    }
    
    private init() {}

} // DebugManager
```

```swift
// 아무데나 사용
DebugManager.shared.log("앱 실행")
```

**"전역 접근성”이 바로 싱글톤이 위험한 이유**

---

## 안티패턴이 되는 이유

| 문제                               | 설명                                                                                        |
| -------------------------------- | ----------------------------------------------------------------------------------------- |
| **전역 상태(Global State)**        | 앱 어디서나 접근할 수 있으므로, 상태가 예측 불가능하게 바뀜<br> -> 사이드 이펙트(부작용) 발생, 디버깅 어려움                       |
| **의존성 숨김 (Hidden Dependency)** | 함수나 객체가 내부적으로 싱글톤을 사용하면, 외부에서 의존 관계를 알 수 없음<br> -> DI(Dependency Injection) 불가능, 테스트 어려움 |
| **단일 책임 원칙 위배 (SRP)**          | 싱글톤은 전역 관리와 내부 로직을 모두 담당하게 되어, 책임이 복잡해짐                                                  |
| **테스트 어려움**                    | 전역 상태이므로, 테스트 간 독립성이 깨짐<br> -> 하나의 테스트가 다른 테스트에 영향을 미침                                   |
| **수명 관리 불명확**                  | 앱 시작 시 생성되고 끝날 때까지 살아있음<br> -> 메모리 누수 혹은 필요 이상 오래 유지될 수 있음                               |
| **확장성 저하**                     | 나중에 여러 인스턴스를 만들어야 하는 상황이 오면 구조를 통째로 바꿔야 함                                                |

---

### 1. 전역 상태로 인한 문제

```swift
final class GameManager: @unchecked Sendable {
    static let shared = GameManager()

    var score = 0
    private init() {}

} // GameManager
```

```swift
func addBonus() {
    GameManager.shared.score += 10
}
```

```swift
func resetScore() {
    GameManager.shared.score = 0
}
```


`addBonus()`와 `resetScore()`가 서로 다른 파일에 있을 경우

- 언제, 어디서 `score`를 변경했는지 추적이 불가능

- 디버깅 시 로그 찍어도 원인을 찾기가 힘듬

---

### 2. 의존성 숨김 (Hidden Dependency)

```swift
// 의존성이 숨겨지는 버전

final class UserManager {
    func saveUser(name: String) {
        DebugManager.shared.log("Saving user: \(name)")
        print("User \(name) saved!")
    }
} // UserManager

// ....

let manager = UserManager()
manager.saveUser(name: "B0X")
```

- `DebugManager`가 내부에서 직접 사용됨 (숨겨진 의존성)

- 테스트 시에 `Mock` 로 교체할 수도 없음

```swift
// 올바른 버전

protocol Loggable {
    func log(_ message: String)
}

final class Logger: Loggable {
    func log(_ message: String) { print("[LOG] \(message)") }
}

final class UserManager2 {
    private let logger: Loggable
    
    init(logger: Loggable) {
        self.logger = logger
    }
    
    func saveUser(name: String) {
        logger.log("Saving user: \(name)")
    }
}

let manager2 = UserManager2(logger: Logger())
manager2.saveUser(name: "B0X")
```

---

### 3. 단일 책임 원칙 위배 (SRP)

```swift
// 문제가 되는 버전
final class SettingsManager : @unchecked Sendable {
    static let shared = SettingsManager()
    private init() {}

    var themeColor: String = "blue"        // 상태 관리
    var userName: String?                  // 데이터 관리
    
    func saveSettings() { print("저장 완료") } // 로직 수행
    func loadSettings() { print("불러오기 완료") }
} // SettingsManager
```

역할이 너무 많음

```swift
// 권장되는 버전

struct UserSettings {
    var themeColor: String
    var userName: String
} // UserSettings

final class SettingsStorage {
    func save(_ settings: UserSettings) { print("저장 완료") }
    func load() -> UserSettings { UserSettings(themeColor: "blue", userName: "B0X") }
} // SettingsStorage
```

---

### 4. 테스트의 어려움

```swift
func testAddBonus() {
    GameManager.shared.score = 0
    addBonus()
    assert(GameManager.shared.score == 10)
}

func testResetScore() {
    addBonus()
    resetScore()
    assert(GameManager.shared.score == 0)
}
```

- 두 테스트를 순차적으로 실행하면, `GameManager.shared`가 상태를 공유함

- 테스트 간에 서로 영향을 줍

---

### 5. 수명 관리 불명확 

```swift
final class NetworkCache: @unchecked Sendable {
    static let shared = NetworkCache()
    private init() {}
    
    var cache: [String: Data] = [:]
} // NetworkCache

func downloadData() {
    // 다운로드할 때마다 데이터 캐싱
    NetworkCache.shared.cache["/api/user"] = Data(repeating: 0, count: 100_000)
}

// 앱이 끝날 때까지 NetworkCache.shared는 유지
for _ in 0..<1000 {
    downloadData()
}

print("Cache size:", NetworkCache.shared.cache.count)
```

- 캐시가 전역적으로 유지되어 앱 종료 전까지 메모리에 남음

- 필요 없는 시점에서도 해제되지 않음 -> 메모리 낭비

---

### 6. 확장성 저하

```swift
final class APIService: @unchecked Sendable {
    static let shared = APIService()
    private init() {}
    
    func fetchData() { print("Fetching data from default API...") }
}

let apiService = APIService() // private ini으로 인한 에러
```

- 싱글톤은 **"하나만 존재"** 라는 전제에 묶여 있어,

- 나중에 여러 개의 인스턴스를 만들어야 하면 구조를 전면 수정해야 함

---

## 참고

- [블로그 참고 - 싱글톤 패턴은 안티 패턴일까?(용로그)](https://developer-nyong.tistory.com/29)

- [블로그 참고 - 싱글톤 패턴을 경계하는 사람들의 이야기(여우 블로그)](https://velog.io/@backfox/%EC%8B%B1%EA%B8%80%ED%86%A4-%ED%8C%A8%ED%84%B4%EC%9D%84-%EA%B2%BD%EA%B3%84%ED%95%98%EB%8A%94-%EC%82%AC%EB%9E%8C%EB%93%A4%EC%9D%98-%EC%9D%B4%EC%95%BC%EA%B8%B0#:~:text='%ED%81%B4%EB%9E%98%EC%8A%A4%EC%9D%98%20%EC%9D%B8%EC%8A%A4%ED%84%B4%EC%8A%A4%EA%B0%80%20%EB%94%B1%201%EA%B0%9C%EB%A7%8C%20%EC%83%9D%EC%84%B1%EB%90%98%EB%8A%94%20%EA%B2%83%EC%9D%84%20%EB%B3%B4%EC%9E%A5%ED%95%98%EB%8A%94,%EC%9D%B8%EC%8A%A4%ED%84%B4%EC%8A%A4%EA%B0%80%20%EB%94%B1%201%EA%B0%9C%EB%A7%8C%20%EC%83%9D%EC%84%B1%EB%90%98%EB%8A%94%20%EA%B2%83%EC%9D%84%20%EB%B3%B4%EC%9E%A5%ED%95%98%EA%B8%B0%20%EC%96%B4%EB%A0%B5%EB%8B%A4.)

- [블로그 참고 - 프로퍼티가 없는 객체? Singleton Pattern, Static function 그리고 Struct(tmfrlrkvlek)](https://velog.io/@tmfrlrkvlek/%ED%94%84%EB%A1%9C%ED%8D%BC%ED%8B%B0%EA%B0%80-%EC%97%86%EB%8A%94-%EA%B0%9D%EC%B2%B4-Singleton-Pattern-Static-function-%EA%B7%B8%EB%A6%AC%EA%B3%A0-Struct)