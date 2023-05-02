import Foundation

func solution(_ a:Int, _ b:Int, _ n:Int) -> Int {
    var answer: Int = 0
    var coke: Int = n // 콜라수
    
    // 콜라수가 빌때가지
    // 20 +10 +5 (+1) +2 + 1
    while coke >= a {
        answer += ((coke / a) * b)
        coke = (coke / a * b) + (coke % a) // b를 까먹으면 안됌
    }
    return answer
}