func solution(_ num:Int) -> Int {
    var answer: Int = 0 // 정답
    var num = num // 숫자
    
    // 1이 될때 까지 반복
    while num != 1 {
        if num % 2 == 0 {
            num /= 2
        } else {
            num = num * 3 + 1
        }
        answer += 1
        
        // 탈출 조건
        if answer == 500 {
            answer = -1
            break
        }
    }
    return answer
}