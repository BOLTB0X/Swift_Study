import Foundation

func solution(_ my_string:String) -> String {
    var answer : String = ""
    
    // for문 이용
    for mystr in my_string {
        // 있다면
        if answer.contains(mystr) {
            continue; // 패스
        } else { // 없다면
            answer += String(mystr)
        }
    }
    return answer
}