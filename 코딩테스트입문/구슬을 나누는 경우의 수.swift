import Foundation

// 팩토리얼
func factorial(_ n: Int) -> Double {
        return Double((1...n).reduce(1.0){ Double($0) * Double($1) })
    }

func solution(_ balls:Int, _ share:Int) -> Int {
    // 같은 경우
    if balls == share {
        return 1
    }
    // round 는 Double
    return Int(round(factorial(balls) / factorial(share) / factorial(balls-share)))
}