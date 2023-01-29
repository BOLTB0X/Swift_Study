import Foundation

func solution(_ array:[Int]) -> Int {
    return array.sorted()[array.count / 2] // 정렬 후 중앙값
}