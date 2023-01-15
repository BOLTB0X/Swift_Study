import Foundation

func solution(_ numbers:[Int]) -> [Int] {
    var answer : [Int] = []
    for num in numbers {
         answer.append(num * 2)
    }
    return answer
}