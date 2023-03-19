import Foundation

func solution(_ sizes:[[Int]]) -> Int {
    var w:Int = 0 // 가로
    var h:Int = 0 // 세로

    for size in sizes {
        // 가로는 최댓값중 최대
        // 세로는 최솟값중 최대
        w = max(w, size.max()!) 
        h = max(h, size.min()!)

    }
    return w * h
}