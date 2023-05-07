import Foundation

func solution(_ l:Int, _ r:Int) -> [Int] {
    var answer:[Int] = []
    
    for i in l...r {
        // allSatisfy 이용
        if String(i).allSatisfy({ $0 == "0" || $0 == "5" }) {
            answer.append(i)
        }
    }
    return answer.isEmpty ? [-1] : answer
}