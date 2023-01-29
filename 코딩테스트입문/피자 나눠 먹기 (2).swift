import Foundation

func solution(_ n:Int) -> Int {
    // 반복문 내 나눠떨어 지는경우
    for i in 1...100 where i * 6 % n == 0 {
        return i
    }
    return 0
}