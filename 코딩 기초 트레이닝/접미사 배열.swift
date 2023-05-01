import Foundation

func solution(_ my_string:String) -> [String] {
    var answer:[String] = []
    var arr = my_string.map{String($0)}
    
    for i in 0..<arr.count {
        answer.append(arr[i..<arr.count].joined())
    }
    return answer.sorted()
}