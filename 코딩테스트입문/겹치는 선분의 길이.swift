import Foundation

func solution(_ lines:[[Int]]) -> Int {
    // 좌표
    var board : [Int] = Array(repeating: 0, count: 201)
    
    for line in lines {
        // 해당 좌표에 +100하고 1로 체크
        for i in line[0]+100..<line[1]+100 {
            board[i] += 1
        }
    }
    
    // 겹친것은 1이상 2이므로
    // 2의 갯수가 겹치는 선분의 길이
    return board.filter {$0 > 1}.count
}