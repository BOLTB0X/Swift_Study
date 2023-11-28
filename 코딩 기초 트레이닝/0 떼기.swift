// https://school.programmers.co.kr/learn/courses/30/lessons/181847
import Foundation

func solution(_ n_str:String) -> String {
    var answer:String = ""
    var n_str = n_str.map { String($0) }
    var head:Int = 0
    
    while head < n_str.count && n_str[head] == "0" {
        head += 1
    }
    
    answer = n_str[head...].joined()
    return answer
}