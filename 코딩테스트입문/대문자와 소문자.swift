import Foundation

func solution(_ my_string:String) -> String {
    var answer : String = ""
    
    for my_str in my_string {
        // 만약 대문자이면
        if my_str.isUppercase {
            answer += my_str.lowercased() // uppercased 이용
        } else { // 소문자이면
            answer += my_str.uppercased() // lowercased 이용
        }
    }
    return answer
}