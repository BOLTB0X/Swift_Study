import Foundation

func solution(_ a:Int, _ b:Int) -> Int {
    var _a = a
    var _b = b
    
    while _b % 2 == 0 {_b /= 2}
    while _b % 5 == 0 {_b /= 5}
    return _a % _b == 0 ? 1 : 2
}