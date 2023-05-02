func solution(_ n:Int) -> Int {
    var answer: Int = 0 // 정답
    var isPrimeArray: [Bool] = Array(repeating: true, count: n + 1) // 소수 배열 생성
    
    // 소수는 1처리
    isPrimeArray[0] = false
    isPrimeArray[1] = false
    
    for i in 0...n {
        // 소수 발견
        // 소수의 배수는 소수가 아니므로
        // false 처리
        if isPrimeArray[i] {
            for j in stride(from: i * 2, through: n, by: i) {
                isPrimeArray[j] = false
            }
            answer += 1
        }
    }
    return answer
}