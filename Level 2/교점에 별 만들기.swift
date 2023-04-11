import Foundation

func solution(_ line:[[Int]]) -> [String] {
    var answer:[String] = []
    var pointsArr:[(x: Int, y:Int)] = []
    
    var maxX = Int.min
    var maxY = Int.min
    var minX = Int.max
    var minY = Int.max
    
    for i in 0..<line.count-1 {
        let a = line[i][0]
        let b = line[i][1]
        let e = line[i][2]
        for j in i+1..<line.count {
            let c = line[j][0]
            let d = line[j][1]
            let f = line[j][2]
            
            let adbc = (a*d)-(b*c)
            if adbc == 0 {
                continue
            }
            
            let bfed = (b*f)-(e*d)
            let ecaf = (e*c)-(a*f)
            // 교점 X
            if bfed%adbc != 0 || ecaf%adbc != 0 {
                continue
            }
            
            let p1 = bfed/adbc
            let p2 = ecaf/adbc
            pointsArr.append((p1, p2))
            
            maxX = max(maxX, pointsArr.last!.x)
            maxY = max(maxY, pointsArr.last!.y)
            minX = min(minX, pointsArr.last!.x)
            minY = min(minY, pointsArr.last!.y)
        }
    }
    
    // 격자판 생성
    var board = Array(repeating: Array(repeating: ".", count: maxX - minX + 1), count: maxY - minY + 1)
    
    // 별찍기
    for ps in pointsArr {
        board[ps.y-minY][ps.x-minX] = "*"
    }
    
    for b in board.reversed() {
        answer.append(b.reduce("", +))
    }
    return answer
}