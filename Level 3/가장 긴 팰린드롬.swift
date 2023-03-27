import Foundation

func solution(_ s:String) -> Int {
    var s = Array(s) // 편의용
    var size = s.count // 입력의 길이
    
    for i in (1...size).reversed() {
        // 왼쪽 시작 설정
        for l in 0...size-i {
            var r = l+i-1 // 오른쪽
            var check = true
            
            // 절반으로 나눠서 검사
            for j in 0..<i/2 {
                // 틀렸을 경우
                if s[l+j] != s[r-j] {
                    check = false
                    break
                }
            }
            
            if check { // 팰린드롬이면
                // 현재 사이즈 리턴
                return i
            }
        }
    }
    return 1
}