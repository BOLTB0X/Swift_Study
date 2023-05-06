import Foundation

func solution(_ arr:[Int], _ queries:[[Int]]) -> [Int] {
    var arr = arr
    for q in queries {
        arr.swapAt(q[0], q[1])
    }
    return arr
}