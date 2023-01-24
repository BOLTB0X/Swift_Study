import Foundation

func solution(_ n:Int) -> [Int] {
    var answer = [Int]()
    
    for i in 1...n {
        if n % i == 0 { // 나누어 떨어지는 i가 n의 약수
            answer.append(i)
        }
    }
    
    return answer
}