func solution(_ a:Int, _ b:Int) -> Int64 {
    var answer = 0
    
    // 단순 무식방법
    if a > b {
        for i in b...a {
            answer += i
        }
    } else {
        for i in a...b {
            answer += i
        }
    }
    
    return Int64(answer)
}