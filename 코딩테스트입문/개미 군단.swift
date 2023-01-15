import Foundation

func solution(_ hp:Int) -> Int {
    var answer = 0
    var cur = hp // 체력
    
    // 그리디
    for power in [5, 3, 1] {
        answer += cur / power
        cur %= power
    }
    return answer
}