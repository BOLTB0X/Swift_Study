import Foundation

func solution(_ n:Int, _ k:Int) -> Int {
    // 단순 계산
    return n * 12000 - 2000 * (n/10) + k * 2000
}