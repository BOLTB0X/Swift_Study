import Foundation

func solution(_ q:Int, _ r:Int, _ code:String) -> String {
    var answer:String = ""
    
    for i in code.enumerated() {
        if i.0 % q == r {
            answer.append(i.1)
        }
    }
    return answer
}