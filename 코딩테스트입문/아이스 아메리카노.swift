import Foundation

func solution(_ money:Int) -> [Int] {
    // 그냥 산수
    return [Int(money / 5500), Int(money % 5500)]
}