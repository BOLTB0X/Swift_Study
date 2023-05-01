import Foundation

func solution(_ my_strings:[String], _ parts:[[Int]]) -> String {
    var answer:String = ""
    
    for i in 0..<my_strings.count {
        let str = my_strings[i].map{String($0)}
        answer += str[parts[i][0]...parts[i][1]].joined()
    }
    return answer
}