import Foundation

final class DebugManager: @unchecked Sendable {
    static let shared = DebugManager()

    func log(_ message: String) {
        print("[LOG]", message)
    }
    
    private init() {}

} // DebugManager

DebugManager.shared.log("앱 실행")

// 1. 전역 상태로 인한 부작용
final class GameManager: @unchecked Sendable {
    static let shared = GameManager()

    var score = 0
    private init() {}

} // GameManager

func addBonus() {
    GameManager.shared.score += 10
}

func resetScore() {
    GameManager.shared.score = 0
}

final class UserManager {
    func saveUser(name: String) {
        DebugManager.shared.log("Saving user: \(name)")
        print("User \(name) saved!")
    }
} // UserManager

let manager = UserManager()
manager.saveUser(name: "B0X")


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


// 단일원칙 위배

final class SettingsManager : @unchecked Sendable {
    static let shared = SettingsManager()
    private init() {}

    // ⚠️ 역할이 너무 많음!
    var themeColor: String = "blue"        // 상태 관리
    var userName: String?                  // 데이터 관리
    
    func saveSettings() { print("저장 완료") } // 로직 수행
    func loadSettings() { print("불러오기 완료") }
} // SettingsManager

struct UserSettings {
    var themeColor: String
    var userName: String
}

final class SettingsStorage {
    func save(_ settings: UserSettings) { print("저장 완료") }
    func load() -> UserSettings { UserSettings(themeColor: "blue", userName: "B0X") }
} // SettingsStorage


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

final class APIService: @unchecked Sendable {
    static let shared = APIService()
    private init() {}
    
    func fetchData() { print("Fetching data from default API...") }
}

//let apiService = APIService()


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
