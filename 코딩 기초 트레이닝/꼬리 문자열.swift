import Foundation

func solution(_ str_list:[String], _ ex:String) -> String {
    var answer:String = ""
    
    for str in str_list {
        if str.contains(ex) == true {
            continue
        }
        answer += str
    }
    return answer
}