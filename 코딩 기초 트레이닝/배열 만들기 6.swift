import Foundation

func solution(_ arr:[Int]) -> [Int] {
    var stk:[Int] = []
    
    for i in 0..<arr.count {
        if stk.count == 0 {
            stk.append(arr[i])
        } else if stk.last! == arr[i] {
            stk.removeLast()
        } else if stk.last! != arr[i]{
            stk.append(arr[i])
        }
    }
    return stk.count == 0 ? [-1] : stk
}