import Foundation

func solution(_ order:Int) -> Int {
    // 클로져 이용
    // filter
    return String(order).filter{$0 == "3" || $0 == "6" || $0 == "9"}.count
}