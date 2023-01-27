import Foundation

func solution(_ array:[Int], _ height:Int) -> Int {
    // 필터 이용
    array.filter { $0 > height}.count
}