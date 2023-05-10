import Foundation

func solution(_ my_string:String, _ indices:[Int]) -> String {
    var arr = my_string.map{String($0)} // 편의용
    
    for i in indices {
        arr[i] = "0"
    }
    return arr.filter{$0 != "0"}.joined()
}