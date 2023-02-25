import Foundation // sqrt를 위해

func solution(_ n:Int64) -> Int64 {
    // 루트를 이용하여 제곱근 봄
    // 범위가 크니 Int64로
    var sqrtN = Int64(sqrt(Double(n)))
    
    // 삼항연산자로 문제조건 적어줌
    return sqrtN * sqrtN == n ? (sqrtN+1) * (sqrtN+1) : -1
}