import Foundation

func solution(_ my_string:String, _ m:Int, _ c:Int) -> String {
    var answer: String = ""
    let my_string = my_string.map { String($0) }
    
    for i in stride(from: 0, to: my_string.count, by: m) {
        answer += Array(my_string[i..<i+m])[c-1]
    }
    
    return answer
}