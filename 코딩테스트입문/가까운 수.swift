import Foundation

func solution(_ array:[Int], _ n:Int) -> Int {
    // 클로져 이용
    return array.min { (abs($0 - n), $0) < (abs($1 - n), $1) }!

}