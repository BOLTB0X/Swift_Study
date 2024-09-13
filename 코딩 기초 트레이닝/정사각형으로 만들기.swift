import Foundation

func solution(_ arr:[[Int]]) -> [[Int]] {
    var answer = arr
    let size = max(arr.count, arr[0].count)
    
    if arr.count == size && arr[0].count == size {
        return answer
    }
    
    for i in arr.indices {
        for _ in (0..<(size-arr[i].count)) {
            answer[i].append(0)
        }
    }
    
    for _ in (0..<(size-arr.count)) {
        answer.append(Array(repeating: 0, count: size))
    }
    
    return answer
}