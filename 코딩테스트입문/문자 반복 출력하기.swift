import Foundation

func solution(_ my_string:String, _ n:Int) -> String {
    var answer : String = ""
    
    // 반목문 이용
    for str in my_string {
        for i in 1...n {
            answer.append(str)
        }
    }
    return answer
}