import Foundation

func solution(_ arr:[Int], _ n:Int) -> [Int] {
    var arr = arr
    
    if arr.count % 2 == 0 {
        for i in 0..<arr.count {
            if i % 2 == 1 {
                arr[i] += n
            }
        }
    } else {
        for i in 0..<arr.count {
            if i % 2 == 0 {
                arr[i] += n
            }
        }
    }
    return arr
    // return arr.indices.map { arr[$0] + ($0 % 2 == (arr.count % 2 == 0 ? 1 : 0) ? n : 0) }
}