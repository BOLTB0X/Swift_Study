import Foundation

func solution(_ n:Int) -> Int {
    // 다른 풀이
    // floor = 소수점을 버리는 함수
    // 암시적 표현
    sqrt(Double(n)) == floor(sqrt(Double(n))) ? 1 : 2
}