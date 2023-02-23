func solution(_ s:String) -> Int {
    // 단순풀이
    var answer: Int = 0
    var sArr = Array(s) // 편의용
    
    if sArr.count == 0 { // 빈 문자열인경우
        answer = 0
    } else {
        if sArr[0] == "-" {
            sArr.removeFirst()
            answer = Int(String(sArr))!
            answer *= -1
        } else if sArr[0] == "+" {
            sArr.removeFirst()
            answer = Int(String(sArr))!
        } else {
            answer = Int(String(sArr))!
        }
    }
    return answer
    // 요것도 됌
    // return Int(s)!
}