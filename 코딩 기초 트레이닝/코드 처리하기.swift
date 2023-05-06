import Foundation

func solution(_ code:String) -> String {
    var answer:[String] = []
    var code = code.map{String($0)} // 편의상
    var flag:Int = 0
    
    for i in 0..<code.count {
        if code[i] == "1" {
            if flag == 0 {
                flag = 1
            } else {
                flag = 0
            }        
        } else {
            if flag == 0 && i % 2 == 0{
                answer.append(code[i])
            } else if flag == 1 && i % 2 == 1 {
                answer.append(code[i])
            }
        }
    }
    
    if answer.count == 0 {
        return "EMPTY"
    }
    return answer.joined()
}