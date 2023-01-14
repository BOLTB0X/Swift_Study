import Foundation

func solution(_ emergency:[Int]) -> [Int] {
    var answer: [Int] = Array(repeating: 0, count: emergency.count)
    // 순번을 알기위해 내림차순 정렬
    var tmp: [Int] = emergency.sorted(by: >)
    
    for (idx1, t) in tmp.enumerated() {
        // ex)
        // 76 24 3
        // 3 76 24
        // 3  1  2
        for (idx2, e) in emergency.enumerated() {
            // 해당 원소를 찾았다면
            if t == e {
                answer[idx2] = idx1 + 1
            }
        }
    }
    
    return answer
}