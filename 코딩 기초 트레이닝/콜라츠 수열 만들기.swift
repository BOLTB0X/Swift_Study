import Foundation

func solution(_ n:Int) -> [Int] {
    var answer: [Int] = [n]
    var n = n
    
    while n != 1 {
        if n % 2 == 0 {
            n /= 2
        } else {
            n = 3 * n + 1
        }
        
        answer.append(n)
    }
    
    return answer
}