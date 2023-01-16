import Foundation

func solution(_ num_list:[Int], _ n:Int) -> [[Int]] {
    // 스위프트는 파이썬과 다르게
    // 2차원 배열 타입 형을 먼저 사용해야함
    var answer = Array(repeating: Array(repeating: 0, count: n), count: num_list.count / n)
    // idx 용
    var idx = 0
    
    for i in answer.indices {
        for j in answer[0].indices {
            answer[i][j] = num_list[idx]
            idx += 1
        }
    }
    return answer
}