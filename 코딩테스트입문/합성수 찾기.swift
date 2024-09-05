import Foundation

func solution(_ n:Int) -> Int {
    (1...n).filter { isComposition($0) }.count
}

func isComposition(_ n: Int) -> Bool {
    (1...n).filter { n % $0 == 0 }.count >= 3 ? true : false
}