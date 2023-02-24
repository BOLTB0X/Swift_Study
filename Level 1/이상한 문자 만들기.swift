func solution(_ s:String) -> String {
    var answer:[String] = [] // 정답
    var idx = 0 // 인덱스
    
    // 완전탐색 시작
    for i in s {
        // 공백이면 
        if i == " " {
            idx = 0 // 인덱스를 초기화 하고
            answer.append(" ")
            continue // 바로 넘어감
        } else { // 변환을 해야하는 경우
            // 짝수이면
            if idx % 2 == 0 {
                answer.append(i.uppercased()) // 대문자로
            } else { // 홀수이묜
                answer.append(i.lowercased()) // 소문자로
            }
        }
        idx += 1 // 증감
    }
    
    // 문자열로 변환
    return answer.joined()
}