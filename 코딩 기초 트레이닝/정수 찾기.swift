import Foundation

func solution(_ num_list:[Int], _ n:Int) -> Int {
    return num_list.contains(n) == true ? 1 : 0
}