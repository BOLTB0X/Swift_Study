import Foundation

func solution(_ n:Int) -> [[Int]] {
    var answer:[[Int]] = Array(repeating: Array(repeating: 0, count: n), count: n)
    var dir = 0 // 방향
    var cy = 0
    var cx = 0
    var number = 1
    
    // 모든 정수 값을 배열에 채우면 종료
    while (number <= n * n) { 
        answer[cx][cy] = number
        number += 1

        // 오른쪽 방향으로 이동
        if dir == 0 {
            if cy == n - 1 || answer[cx][cy + 1] != 0 {
                dir = 1
                cx += 1
            } else {
                cy += 1
            }
        } else if dir == 1 { // 아래쪽 방향으로 이동
            if cx == n - 1 || answer[cx + 1][cy] != 0 {
                dir = 2
                cy -= 1
            } else {
                cx += 1
            }
        } else if dir == 2 { // 왼쪽 방향으로 이동
            if cy == 0 || answer[cx][cy - 1] != 0 {
                dir = 3
                cx -= 1
            } else {
                cy -= 1
            }
        } else if dir == 3 { // 위쪽 방향으로 이동
            if cx == 0 || answer[cx - 1][cy] != 0 {
                dir = 0
                cy += 1
            } else {
                cx -= 1
            }
        }
    }
    
    return answer
}