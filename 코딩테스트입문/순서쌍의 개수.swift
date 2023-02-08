import Foundation

func solution(_ n:Int) -> Int {
    var answer = 0
    
    // 나누어떨어지는 경우 확인
    for i in 1...n where n % i == 0 {
        answer += 1
    }
    return answer
}