import Foundation

func solution(_ wallpaper:[String]) -> [Int] {
    var maxX:Int = Int.min
    var maxY:Int = Int.min
    var minX:Int = Int.max
    var minY:Int = Int.max
    
    var _wallpaper:[[String]] = []
    
    // 편의용
    for i in 0..<wallpaper.count {
        _wallpaper.append(wallpaper[i].map{String($0)})
    }
    
    // 생각하면 간단한 문제
    // 행렬의 행,열이 그냥 한칸 전이라 생각하면 됐던 문제
    for i in 0..<_wallpaper.count {
        for j in 0..<_wallpaper[i].count {
            if _wallpaper[i][j] == "#" {
                maxX = max(maxX, i)
                maxY = max(maxY, j)
                minX = min(minX, i)
                minY = min(minY, j)
            }
        }
    }
    return [minX, minY, maxX+1, maxY+1]
}