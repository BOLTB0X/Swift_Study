import Foundation

func solution(_ num_list:[Int], _ n:Int) -> [Int] {
    var arr = num_list
    for _ in 0..<n {
        let num = arr.first!
        arr.removeFirst()
        arr.append(num)
    }
    return arr
}