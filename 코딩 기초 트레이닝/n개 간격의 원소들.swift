import Foundation

func solution(_ num_list:[Int], _ n:Int) -> [Int] {
    return (0..<num_list.count).filter{$0%n == 0}.map{num_list[$0]}
}