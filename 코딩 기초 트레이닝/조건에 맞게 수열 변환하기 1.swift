import Foundation

func solution(_ arr:[Int]) -> [Int] {
    var arr = arr
    
    for i in 0..<arr.count {
        if arr[i] >= 50 && arr[i]%2 == 0 {
            arr[i] /= 2
        } else if arr[i] < 50 && arr[i]%2 == 1 {
            arr[i] *= 2
        } 
    }
    return arr
}