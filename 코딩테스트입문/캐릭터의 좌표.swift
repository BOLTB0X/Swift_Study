import Foundation

func solution(_ keyinput:[String], _ board:[Int]) -> [Int] {
    var x : Int = 0
    var y : Int = 0
    var range : [Int] = board.map {$0 / 2}
    
    for key in keyinput {
        // 방향에 맞추고 현재 위치가 범위에 끝이면 움직이지 않도록
        // where 을 이용
        if key == "left" && x > -range[0] {
            x -= 1
        }
        else if key == "right" && x < range[0] {
            x += 1
        }
        else if key == "up" && y < range[1] {
            y += 1
        } 
        else if key == "down" && y > -range[1] {
            y -= 1    
        }
    }
    return [x, y]
}