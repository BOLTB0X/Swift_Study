func solution(_ seoul:[String]) -> String {
    // 단순풀이
    
    for i in 0..<seoul.count {
        if seoul[i] == "Kim" {
            return "김서방은 \(i)에 있다"
        }
    }
    
    // 참고 코드
    return "김서방은 \(seoul.index(of: "Kim")!)에 있다"
}