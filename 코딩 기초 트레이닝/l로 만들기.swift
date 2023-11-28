// https://school.programmers.co.kr/learn/courses/30/lessons/181834
import Foundation

func solution(_ myString:String) -> String {
    var answer: String = ""
    let alp = "abcdefghijklmnopqrstuvwxyz"
    let lIndex = alp.firstIndex(of: "l")!
    
    myString.forEach {
        if alp.firstIndex(of: $0)! < lIndex {
            answer.append("l")
        } else {
            answer.append($0)
        }
    }
    
    return answer
}