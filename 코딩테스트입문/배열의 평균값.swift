import Foundation

func solution(_ numbers:[Int]) -> Double {
    // reduce
    Double(numbers.reduce(0,+)) / Double(numbers.count)
}