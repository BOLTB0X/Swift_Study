import Foundation

func solution(_ array:[Int]) -> [Int] {
    var maxValue = -1
    var idx = 0
    
    for i in array.indices {
        if array[i] > maxValue {
            maxValue = array[i]
            idx = i
        }
    }
    
    return [maxValue, idx]
}