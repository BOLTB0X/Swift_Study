import Foundation

func solution(_ numbers:[Int]) -> [Int] {
    // 단순풀이
    var answer: [Int] = []
    var tmp: Set<Int> = [] // 중복 방지를 위해
    
    // 완전탐색방식으로
    for i in 0..<numbers.count {
        for j in i+1..<numbers.count {
            tmp.insert(numbers[i] + numbers[j])
        }
    }
    
    // 배열로 변환하고
    answer = Array(tmp)
    
    // 정렬하며 반환
    return answer.sorted()
}