import Foundation

func solution(_ n:Int, _ control:String) -> Int {
    var n = n
    
    for c in control {
        if c == "w" {
            n += 1
        } else if c == "s" {
            n -= 1
        } else if c == "d" {
            n += 10
        } else if c == "a" {
            n -= 10
        }
    }
    return n
}