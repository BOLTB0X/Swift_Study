import Foundation

func solution(_ s:String) -> Int {
    var answer : Int = 0
    // 공백을 기준으로 분리 시켜줌
    var my_s = s.split(separator: " ")
    
    // idx와 값을 쓰기 위해 enumerated 이용
    for (idx, value) in my_s.enumerated() {
        // 빼라는 시그널을 찾으면
        if value == "Z" {
            answer -= Int(String(my_s[idx - 1]))!
        } else {
            answer += Int(value)!
        }
    }
    
    return answer
}