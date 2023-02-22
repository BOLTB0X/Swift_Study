import Foundation

func solution(_ a:[Int], _ b:[Int]) -> Int {
    // 단순풀이
    var answer: Int = 0
    
    for i in 0..<a.count {
        answer += (a[i] * b[i])
    }
    return answer
}