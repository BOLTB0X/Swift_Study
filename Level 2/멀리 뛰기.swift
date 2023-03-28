func solution(_ n:Int) -> Int {
    // 피보나지 수열
    var answer = [1, 2]
    var idx = 0
    
    while answer.count < n {
        answer.append((answer[idx]+answer[idx+1])%1234567)
        idx += 1 
    }
    return answer[n-1]
}