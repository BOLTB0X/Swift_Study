import Foundation

func solution(_ a:Int, _ b:Int, _ c:Int, _ d:Int) -> Int {
    let dice = [a,b,c,d].sorted()
    let numberCount = Set(dice).count
    
    if numberCount == 1 {
        return 1111 * dice[0]
    } else if numberCount == 2 {
        if dice[1] == dice[3] || dice[0] == dice[2] {
            let p = dice[1] == dice[3] ? dice[3] : dice[0]
            let q = dice[1] == dice[3] ? dice[0] : dice[3]
            return (10 * p + q) * (10 * p + q)
        } else {
            return (dice[0] + dice[2]) * abs(dice[0] - dice[2])
        }
    } else if numberCount == 3 {
        if dice[0] == dice[1] && dice[2] != dice[3] {
            return dice[2] * dice[3]
        } else if dice[1] == dice[2] && dice[0] != dice[3] {
            return dice[0] * dice[3]
        } else if dice[2] == dice[3] && dice[0] != dice[1] {
            return dice[0] * dice[1]
        }
    }
    
    return dice[0]
}