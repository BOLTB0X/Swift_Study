import Foundation

func solution(_ my_string:String, _ n:Int) -> String {
    // 노가다 단순 무식 
    var answer:[String] = []
    var my_string = my_string.map{String($0)}
    
    for i in my_string.count-n..<my_string.count {
        answer.append(my_string[i])
    }
    return answer.joined()
    // return String(my_string.suffix(n)) // 뒤에서 자르기
}