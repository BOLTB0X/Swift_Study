import Foundation

func solution(_ slice:Int, _ n:Int) -> Int {
    // 소수점을 반올림 처리
    return Int(ceil(Double(n) / Double(slice)))
}