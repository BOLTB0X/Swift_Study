import Foundation

func solution(_ n:Int) -> Int {
    for i in 1...101 where i * 6 % n == 0 {
            return i
    }
    return 0
}