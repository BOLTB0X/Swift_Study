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
}

let rect = Rectangle()
rect.width = 5.0
rect.height = 4.0
print(rect.area)
// 20.0

rect.area = 40.0
print(rect.width)
// 10.0

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
