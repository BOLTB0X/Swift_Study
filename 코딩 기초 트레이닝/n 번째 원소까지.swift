import Foundation

func solution(_ num_list:[Int], _ n:Int) -> [Int] {
    var answer:[Int] = []
    for i in 0..<n {
        answer.append(num_list[i])
    }
    return answer
    // return Array(num_list[...(n-1)])
}