import Foundation

func solution(_ numLog:[Int]) -> String {
    var answer:String = ""
    
    for i in 1..<numLog.count { // 현재 numLog 해당 idx를 보지 말고
        // 그 전것과 비교하며 명령어를 찾아야함
        let diff = numLog[i] - numLog[i-1]
        
        if diff == 1 {
            answer.append("w")
        } else if diff == -1 {
            answer.append("s")
        } else if diff == 10 {
            answer.append("d")
        } else {
            answer.append("a")
        }
    }
    return answer
}