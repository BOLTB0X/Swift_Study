import Foundation

func solution(_ num_list:[Int]) -> Int {
    var totOdd:String = ""
    var totEven:String = ""
    
    for i in 0..<num_list.count {
        if num_list[i]%2 == 1 {
            totOdd.append(String(num_list[i]))
        } else {
            totEven.append(String(num_list[i]))
        }
    }
    // let even = Int(num_list.filter { $0 % 2 == 0 }.map { String($0) }.joined())!
    // let odd = Int(num_list.filter { $0 % 2 != 0 }.map { String($0) }.joined())!
    return Int(totOdd)!+Int(totEven)!
}