import Foundation

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

let rect = Rectangle()
rect.width = 5.0
rect.height = 4.0
print(rect.area)

print(rect.per)
// 20.0

rect.area = 40.0
print(rect.width)
// 10.0

struct Counter {
    var value: Int = 0

    var doubled: Int {
        mutating set {
            value = newValue / 2
        }
        get { value * 2 }
    }
}

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


var value: Int = 0 {
    willSet(next) {
        print("about to set to \(next)")
    }
    didSet(prev) {
        print("changed from \(prev)")
    }
}


struct TimerModel {
    // 저장 프로퍼티 (옵저버 사용)
    var seconds: Int = 0 {
        willSet {
            print("will set seconds -> \(newValue)")
        }
        didSet {
            print("did set seconds: \(oldValue) -> \(seconds)")
        }
    }

    // 계산 프로퍼티 (get/set) — read-only 가능
    var minutes: Int {
        get { seconds / 60 }
        set {
            // 값을 분 단위로 설정하면 seconds를 갱신
            seconds = newValue * 60
        }
    }

    // 읽기 전용 계산 프로퍼티 (한 줄 shorthand)
    var display: String { "\(minutes)m \(seconds % 60)s" }
}

var t = TimerModel()
t.seconds = 90
// will set seconds -> 90
// did set seconds: 0 -> 90

print(t.display) // "1m 30s"
t.minutes = 2    // setter 호출 -> seconds = 120



