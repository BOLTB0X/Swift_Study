import Foundation

func solution(_ arr:[Int], _ queries:[[Int]]) -> [Int] {
    var answer:[Int] = arr
    
    for q in queries {
        for i in q[0]...q[1] {
            if i % q[2] == 0 {
                answer[i] += 1
            }
        }
    }
    
    return answer
}