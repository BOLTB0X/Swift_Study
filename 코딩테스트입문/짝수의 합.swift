import Foundation

func solution(_ n:Int) -> Int {
    var answer : Int = 0
    
    // for문으로 짝수만 
    for i in 2...n where i % 2 == 0 {
        answer += i
    }
    return answer
}