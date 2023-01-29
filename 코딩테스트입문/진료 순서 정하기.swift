import Foundation

func solution(_ emergency:[Int]) -> [Int] {
    // 정답 배열
    var answer: [Int] = Array(repeating: 0, count: emergency.count)
    // 순번을 알기위한 임시배열
    var tmpArray = emergency.sorted(by: >)
    
    // 이중 반복문 이용
    // 내림차순 정렬된 배열을 기준으로
    for (idx, value) in tmpArray.enumerated() {
        // 원본배열 내에서 찾음
        for i in emergency.enumerated() {
            if i.element == value {
                answer[i.offset] = idx + 1
            }
        }
    }
    return answer
}