import Foundation

func solution(_ babbling:[String]) -> Int {
    var answer: Int = 0
    
    for b in babbling {
        if DFS(["aya", "ye", "woo", "ma"], b) {
            answer += 1
        }
    }
    
    return answer
}

func DFS(_ basic: [String], _ remaining: String) -> Bool {
    if remaining.isEmpty { return true }
    
    for b in basic {
        if remaining.hasPrefix(b) {
            if DFS(basic, remaining.components(separatedBy: b)[1]) {
                return true
            }
        }
    }
    return false
}
