import Foundation

func solution(_ num_list:[Int]) -> Int {
    var answer:Int = 0
    var oddTot:Int = 0, evenTot:Int = 0
    
    for i in num_list.indices {
        if i % 2 == 0 {
            evenTot += num_list[i]
        } else {
            oddTot += num_list[i]
        }
    }
    
    //    let oddSum = stride(from: 1, to: numList.count, by: 2).map { numList[$0] }.reduce(0, +)
    // let evenSum = stride(from: 0, to: numList.count, by: 2).map { numList[$0] }.reduce(0, +)
    // return max(oddSum, evenSum)
    return evenTot > oddTot ? evenTot : oddTot
}