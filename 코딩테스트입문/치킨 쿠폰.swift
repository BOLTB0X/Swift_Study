import Foundation

func solution(_ chicken:Int) -> Int {
    // 치킨 갯수
    var chicken_cnt = 0
    // 치킨 수
    var _chicken = chicken
    
    // 산수
    while _chicken >= 10 {
        chicken_cnt += (_chicken / 10)
        _chicken = _chicken / 10 + _chicken % 10
    }
    
    return chicken_cnt
}