import Foundation

func solution(_ n:Int) -> [Int] {
    var answer:[Int] = []
    // 격자판
    var board:[[Int]] = Array(repeating: Array(repeating: 0, count: n), count: n)
    var number:Int = 1
    var y = -1, x = 0
    
    // 아래, 오른쪽 위임
    for i in 0..<n {
        for j in i..<n {
            if i%3 == 0 { // 아래
                y += 1
            } else if i%3 == 1 { // 오른
                x += 1
            } else if i%3 == 2 { // 위
                y -= 1
                x -= 1
            }
            
            board[y][x] = number
            number += 1
        }
    }
    
    for i in 0..<n {
        for j in 0..<n {
            if board[i][j] != 0 {
                answer.append(board[i][j])
            }
        }
    }
    
    return answer
}

print(solution(4))
print("--------------------")
print(solution(5))
print("--------------------")
print(solution(6))
