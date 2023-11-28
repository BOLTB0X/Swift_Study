// https://school.programmers.co.kr/learn/courses/30/lessons/181874
import Foundation

func solution(_ myString:String) -> String {
    var answer:String = ""
    
    for str in myString {
        if str == "a" { //  "a"가 등장하면 전부 "A"로 변환하고,
            answer += "A"
        } else if str != "A" && str.isUppercase {
          answer += str.lowercased()
        } else {
            answer.append(str)
        }
    }
    return answer
}