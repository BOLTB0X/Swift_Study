import Foundation

let dir = [[0, 1], [1, 0], [0, -1], [-1, 0]]

func solution(_ n:Int) -> [[Int]] {
    var answer: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: n)
    var x = 0, y = 0, d = 0, number = 1
    
    for _ in 0..<(n*n) {
        answer[x][y] = number
        number += 1
        
        let nx = x + dir[d][0]
        let ny = y + dir[d][1]
        
        if nx < 0 || ny < 0 || nx >= n || ny >= n || answer[nx][ny] != 0 {
            d = (d + 1) % 4
            x += dir[d][0]
            y += dir[d][1]
            continue
        }
        
        x = nx 
        y = ny
    }
    return answer
}