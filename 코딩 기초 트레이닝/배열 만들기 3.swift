import Foundation

func solution(_ arr:[Int], _ intervals:[[Int]]) -> [Int] {
    var answer:[Int] = []
    
    for interval in intervals {
        for i in interval[0]...interval[1] {
            answer.append(arr[i])
        }
    }
    return answer
}