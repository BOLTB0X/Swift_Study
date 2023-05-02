import Foundation

func solution(_ s:String) -> [Int] {
    var answer:[Int] = []
    var _s = s.map {String($0)} // 편의용
    var cmp:[String] = [] // 비교 샘플
    
    for i in _s.enumerated() { // 완전탐색
        if cmp.contains(i.1) == true { // 샘플에 있다면
            // 샘플에 잇는 인덱스 반환(강제추룰)
            let targetIndex = cmp.lastIndex(of: i.1)!
            answer.append(i.0 - targetIndex)
        } else { // 처음 나온 경우
            answer.append(-1)
        }
        cmp.append(i.1) // 조건에 상관없이 넣어줌
    }

    return answer
}