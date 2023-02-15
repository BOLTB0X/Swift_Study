import Foundation

func solution(_ cipher:String, _ code:Int) -> String {
    var answer: String = ""
    
    // 완전탐색
    for i in cipher.enumerated() {
        if (i.0 + 1) % code == 0 {
            answer += String(i.1)
        }
    }
    return answer
}