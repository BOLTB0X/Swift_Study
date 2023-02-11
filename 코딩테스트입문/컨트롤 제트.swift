import Foundation

func solution(_ s:String) -> Int {
    var answer: Int = 0 // 정답
    var _s = s.split(separator: " ") // 편의를 위해 공백 제거
    
    // idx와 value 사용하기 위해 enumerated 이용
    for i in _s.enumerated() {
        if i.1 == "Z" { // Z를 만나면
            // Index을 이용하여 한 칸 전 원소를 Int형으로 강제 추출 후
            // 뺌
            answer -= Int(_s[i.0 - 1])!
        } else {
            // 그외는 더함 
            answer += Int(i.1)!
        }
    }
    return answer
}