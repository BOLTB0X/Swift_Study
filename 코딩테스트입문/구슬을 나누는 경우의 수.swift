import Foundation

func factorial(_ n: Int) -> Double {
        return Double((1...n).reduce(1.0){ Double($0) * Double($1) })
    }

func solution(_ balls:Int, _ share:Int) -> Int {
    if balls == share {
        return 1
    }
    return Int(round(factorial(balls) / factorial(share) / factorial(balls-share)))
}