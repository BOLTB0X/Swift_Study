import Foundation

func solution(_ num_list:[Int], _ n:Int) -> [Int] {
    return (n-1..<num_list.count).map{num_list[$0]}
}