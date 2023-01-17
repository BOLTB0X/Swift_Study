import Foundation

func solution(_ cipher:String, _ code:Int) -> String {
    var answer = ""
    
    for (idx, value) in cipher.enumerated() {
        if (idx + 1) % code == 0 {
            answer += String(value)
        }
    }
    return answer
}