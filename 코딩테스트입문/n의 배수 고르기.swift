import Foundation

func solution(_ n:Int, _ numlist:[Int]) -> [Int] {
    var answer = [Int]()
    
    for num in numlist {
        if num % n == 0 { // 나누어 떨어지는 경우가 배수
            answer.append(num)
        }
    }
    return answer
}