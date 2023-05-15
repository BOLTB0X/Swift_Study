import Foundation

func powerOfTwo(_ num: Int) -> Bool {
    var num = num
    
    while num >= 1 {
        if num == 1 {
            return true
        }
        if num % 2 != 0 { 
            return false
        }
        num /= 2
    }
    return false
}

func solution(_ arr:[Int]) -> [Int] {
    var arr = arr
    
    while !powerOfTwo(arr.count) {
        arr.append(0)
    }
    return arr
}