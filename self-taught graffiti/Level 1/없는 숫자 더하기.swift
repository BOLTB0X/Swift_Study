import Foundation

func solution(_ numbers:[Int]) -> Int {
    // 단순 풀이
    var answer:Int = 0
    
    for i in 1...9 {
        if numbers.contains(i) {
            continue
        } else {
            answer += i
        }
    }
    return answer
}