import Foundation

func solution(_ l:Int, _ r:Int) -> [Int] {
    let answer = (l...r).filter{String($0).allSatisfy({$0 == "5" || $0 == "0"})}
    return answer.isEmpty ? [-1] : answer
}