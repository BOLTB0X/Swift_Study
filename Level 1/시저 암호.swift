func solution(_ s:String, _ n:Int) -> String {
    var answer: [String] = []
    // 알파벳 배열 [string.element] 로 생성
    let alphArr = "abcdefghijklmnopqrstuvwxyz".map{$0} 
    var s = Array(s) // 편의용
    
    for i in s {
        // 대문자인 경우
        if i.isUppercase {
            // of: 여기가 타입 Character or string.element
            // 밀어야하니 강제추출 후 + n
            var idx = alphArr.firstIndex(of: Character(i.lowercased()))! + n
            // 인덱스 초과 방지
            if idx > 25 {
                idx -= 26
            }

            answer.append(alphArr[idx].uppercased()) // 대문자로 변경 후 푸쉬, uppercased -> string
        } else if i.isLowercase { // 소문자인 경우, 대문자와 비슷하게진행
            var idx = alphArr.firstIndex(of: i)!+n
            if idx > 25 {
                idx -= 26
            }
            answer.append(String(alphArr[idx]))
        } else { // 여백인 경우
            answer.append(" ")
        }
    }

    // 반환이 문자열이므로 joined 이용
    return answer.joined()
}