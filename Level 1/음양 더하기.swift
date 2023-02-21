func solution(_ absolutes:[Int], _ signs:[Bool]) -> Int {
    var answer = 0
    
    for i in signs.indices {
        // 삼항연산자
        // 양이면 더하고 음이면 뺴라
        answer += signs[i] == true ? absolutes[i] : -absolutes[i]
    }
    return answer
}