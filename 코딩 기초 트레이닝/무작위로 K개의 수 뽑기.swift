import Foundation

func solution(_ arr:[Int], _ k:Int) -> [Int] {
    var answer:[Int] = []
    var idx:Int = 0
    
    while true {
        if idx == arr.count || answer.count == k {
            break
        }
    
        
        if !answer.contains(arr[idx]) {
            answer.append(arr[idx])
        }
        
        idx += 1
    }
    
    if answer.count < k {
        for _ in 0..<(k-answer.count) {
            answer.append(-1)
        }
    }
    
    return answer
}