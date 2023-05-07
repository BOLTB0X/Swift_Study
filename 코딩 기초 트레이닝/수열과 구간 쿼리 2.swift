import Foundation

func solution(_ arr:[Int], _ queries:[[Int]]) -> [Int] {
    var answer:[Int] = []
    
    for q in queries {
        var minValue = Int.max
        for i in q[0]...q[1] {
            if arr[i] > q[2] {
                minValue = min(arr[i], minValue)
            }
        }
        if minValue == Int.max { // 없는 경우
            answer.append(-1)
        } else {
            answer.append(minValue)
        }
    }
    return answer
}