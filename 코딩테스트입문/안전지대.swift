import Foundation

let dr = [-1, -1, -1, 0, 1, 1, 1, 0]
let dc = [-1, 0, 1, 1, 1, 0, -1, -1]

func check(_ cr:Int, _ cc:Int, _ len:Int) -> Bool {
    // 범위 안이면
    if 0..<len ~= cr && 0..<len ~= cc {
        return true
    }
    return false
}

func solution(_ board:[[Int]]) -> Int {
    // 매개변수로 입력된 맵을 복사
    var res = board
    let len = board.count
    
    for i in 0..<len {
        for j in 0..<len {
            // 지뢰를 발견한다면
            if board[i][j] == 1 {
                // 8방향 1 처리
                for dir in 0..<8 {
                    let nr = i + dr[dir]
                    let nc = j + dc[dir]
                    
                    // 범위 안이고 0이면
                    if check(nr, nc, len) {
                        res[nr][nc] = 1
                    }
                    
                }
            }
        }
    }

    return res.flatMap({$0}).filter{$0 == 0}.count
}