import Foundation

func solution(_ n:Int) -> Int {
    // 단순 풀이
    return Int(String(String(n, radix: 3).reversed()), radix: 3)!
}