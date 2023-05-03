import Foundation

func solution(_ arr:[Int], _ idx:Int) -> Int {
    var answer:Int = -1
    
    for i in 0..<arr.count {
        if i >= idx && arr[i] == 1 {
            answer = i
            break
        }
    }
    return answer 
}