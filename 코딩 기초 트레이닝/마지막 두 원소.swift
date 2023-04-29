import Foundation

func solution(_ num_list:[Int]) -> [Int] {
    var num_list = num_list
    if num_list.last! > num_list[num_list.count-2] {
        num_list.append(num_list.last!-num_list[num_list.count-2])
    } else {
        num_list += [num_list.last!*2]
    }
    return num_list
}