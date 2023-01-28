import Foundation

func solution(_ dots:[[Int]]) -> Int {
    var w : Int = dots.map { $0[0] }.max()! - dots.map{ $0[0] }.min()! // 가로
    var h : Int = dots.map{ $0[1] }.max()! - dots.map { $0[1] }.min()! // 세로
    return w * ha
}