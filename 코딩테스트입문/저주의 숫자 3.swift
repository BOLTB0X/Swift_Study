import Foundation

func solution(_ n:Int) -> Int {
    var answer : Int = 0
    
    for i in 1...n {
        // for문이 돌때 마다 증가
        answer += 1
        // 문제조건이 3이 들어간 것과 3의 배수가 들어가면 안되므로
        // 3의 배수이면 아닐때 까지 증가
        while String(answer).contains("3") || answer % 3 == 0 {
            answer += 1
        }
    }
    
    return answer
}