import Foundation

func solution(_ arr:[Int], _ query:[Int]) -> [Int] {
    var answer = arr
    
    query.enumerated().forEach {
        if $0.0 % 2 == 0 {
            answer = Array(answer[...$0.1])
        } else {
            answer = Array(answer[$0.1...])
        }
        
    }
    
    return answer
}