import Foundation

func solution(_ board:[[Int]], _ k:Int) -> Int {
    var answer:Int = 0
    for i in 0..<board.count {
        for j in 0..<board[0].count {
            if i + j <= k {
                answer += board[i][j]
            }
        }
    }
    return answer
}