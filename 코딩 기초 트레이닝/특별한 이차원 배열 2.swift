import Foundation

func solution(_ arr:[[Int]]) -> Int {
    for i in 0..<arr.count {
        for j in 0..<arr[0].count {
            if arr[i][j] != arr[j][i] {
                return 0
            }
        }
    }
    return 1
}