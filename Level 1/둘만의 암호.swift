import Foundation

func solution(_ s:String, _ skip:String, _ index:Int) -> String {
    var answer: String = "" // 정답
    
    for _s in s {
        // 현재 _s의 아스키코드값으로 변환
        var asci = Int(UnicodeScalar(String(_s))!.value)
        // 5번 뒤로 밀기
        for _ in 1...index {
            // repeat while 반복문
            repeat {
                asci += 1
                if asci > 122 { // z를 넘어가면
                    asci = 97 // a로 초기화
                }
            // skip에 알파벳이 있다면 반복
        } while(skip.contains(String(UnicodeScalar(asci)!)))
    }
    // 다시 알파벳으로 변경
    answer += String(UnicodeScalar(asci)!)
}
    return answer
}