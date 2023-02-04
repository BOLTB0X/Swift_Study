import Foundation

func solution(_ A:String, _ B:String) -> Int {
    var answer: Int = 0
    
    // 밀 필요가 없다면
    if A == B {
        return 0
    }
    // 편하게 이용하기 위해 배열로 변경
    var _A = A.map{ $0 }
    
    // 길이를 넘어가는 것은 만들지 못하는 것이므르
    // 반목문 조건을 걸어줌
    while answer <= A.count {
        // 마지막 원소를 맨 처음으로
        _A.insert(_A[_A.endIndex - 1], at: 0)
        _A.removeLast() // 마지막 제거
        answer += 1 // 카운트
        
        // 같다면
        if String(_A) == B {
            return answer
        }
    }
    
    return -1 // 다르다면
}