import Foundation

func solution(_ myStr:String) -> [String] {
    var answer:[String] = []
    var arr = myStr.map{String($0)}
    var str:String = ""
    
    for i in 0..<myStr.count {
        if arr[i] == "a" || arr[i] == "b" || arr[i] == "c" {
            if str.count > 0 {
                answer.append(str)
                str = ""
            }
        } else {
            str += arr[i]
        }
    }
    
    if str.count > 0 {
        answer.append(str)
    }
    return answer.isEmpty ? ["EMPTY"] : answer
}