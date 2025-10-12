import Foundation

// 싱글톤 클래스 (상태가 공유됨)
class CounterManager: @unchecked Sendable  {
    static let shared = CounterManager()
    private init() {}

    var count = 0

    func increment() {
        count += 1
    }
}

print("=== 싱글톤 테스트 ===")
let counterA = CounterManager.shared
let counterB = CounterManager.shared

counterA.increment()
counterA.increment()

print("A count:", counterA.count) // 2
print("B count:", counterB.count) // 2 (같은 인스턴스라 상태 공유됨)

counterB.increment()
print("A count:", counterA.count) // 3
print("B count:", counterB.count) // 3

// static 방식 (상태가 없음, 독립적인 기능)
struct Counter {
    static func increment(_ value: Int) -> Int {
        return value + 1
    }
}

print("\n=== static 테스트 ===")
var aCount = 0
var bCount = 0

aCount = Counter.increment(aCount)
aCount = Counter.increment(aCount)
print("A count:", aCount) // 2

bCount = Counter.increment(bCount)
print("B count:", bCount) // 1 (서로 독립된 값)
