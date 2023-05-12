import Foundation

func solution(_ arr:[Int]) -> [Int] {
    var answer:[Int] = []
    if !arr.contains(2) {
        return [-1]
    } else {
        var leftIndex = 0
        var rightIndex = arr.count - 1
        
        while leftIndex <= rightIndex {
            if arr[leftIndex] != 2 {
                leftIndex += 1
            } else if arr[rightIndex] != 2 {
                rightIndex -= 1
            } else {
                answer = Array(arr[leftIndex...rightIndex])
                break
            }
        }
    }
    return answer
}