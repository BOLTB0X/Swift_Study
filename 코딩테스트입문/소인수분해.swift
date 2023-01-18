import Foundation

func solution(_ n:Int) -> [Int] {
    var answer : [Int] = []
    
    for i in 2...n {
        // 나누어 떨어지고 정답 배열에 담겨 있지 않다면
        if n % i == 0 && !answer.contains(where: { i % $0 == 0}) {
            answer.append(i)
        }
    }
    return answer
}