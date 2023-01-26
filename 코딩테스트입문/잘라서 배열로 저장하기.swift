import Foundation

func solution(_ my_str:String, _ n:Int) -> [String] {
    var answer : [String] = []
    var tmp : String = ""
    
    for str in my_str {
        tmp += String(str)
        
        // 임시 문자열을 길이가 n이 되면
        if tmp.count == n {
            answer.append(tmp)
            tmp = "" // 초기화
        }
    }
    
    // 만약 딱 나눠지지 않은 경우 
    if tmp.count > 0 {
        answer.append(tmp)
    }
    return answer
}