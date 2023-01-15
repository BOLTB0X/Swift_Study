import Foundation

func solution(_ n:Int) -> Int {
    for i in 1...1000000 {
        if i * i == n {
            return 1
        }
        // 여기가 왔다면
        else if i == 1000000 {
            return 2
        }
    }
    return 0
}