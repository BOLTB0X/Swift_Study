func solution(_ n:Int) -> Int {
    var answer = [0, 1]
  
    // 재귀로 풀시 시간복잡도 2^n
    // 그러므로 배열에 원소를 넣고 수가 크니 나눠주면서 넣어줌
    for i in 2...n {
        answer.append((answer[i-2] + answer[i-1]) % 1234567)
    }
    
    return answer[n]
}
