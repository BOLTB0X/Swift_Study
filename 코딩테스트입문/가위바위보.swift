import Foundation

func solution(_ rsp:String) -> String {
    var answer = ""
    // 가위 2 바위 0 보 5
    for r in rsp {
        if r == "2" {
            answer.append("0")
        }
        
        else if r == "0" {
            answer.append("5")
        }
        
        else if r == "5" {
            answer.append("2")
        }
    }
    return answer
}