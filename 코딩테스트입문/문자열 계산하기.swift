import Foundation

func solution(_ my_string:String) -> Int {
    var answer : Int = 0
    var splitStr = my_string.split(separator : " ")
    
    // 앞에 정수 값 
    answer = Int(splitStr[0])!
    
    // 반복문 이용
    for i in splitStr.enumerated() {
        // +이면
        if i.1 == "+" {
            answer += Int(splitStr[i.0 + 1])!
        } 
        // - 이면
        if i.1 == "-" {
            answer -= Int(splitStr[i.0 + 1])!
        }
    }
    return answer
}