import Foundation

func solution(_ n:Int) -> Int {
    // 단순 풀이
    var answer:Int = 1
    
    while true {
        if n % answer == 1 {
            break
        }
        answer += 1
    }
    return answer
}