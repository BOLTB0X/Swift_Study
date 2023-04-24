import Foundation

func solution(_ my_string:String, _ k:Int) -> String {
    var answer:String = ""
    
    for i in 0..<k {
        answer.append(my_string)
    }
    return answer
    // String(repeating: my_string, count: k) 요것도 됌
}