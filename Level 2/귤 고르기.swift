import Foundation

func solution(_ k:Int, _ tangerine:[Int]) -> Int {
    var answer: Int = 0
    var occ:[Int] = Array(repeating: 0, count: tangerine.max()!) // 빈도수
    var _k = k // 편의용
    
    // 귤 갯수 카운트
    for i in 0..<tangerine.count {
        occ[tangerine[i] - 1] += 1
    }

    occ.sort(by: >) // 정렬

    while _k > 0 { // 다 고를때 까지 반복
        _k -= occ[answer] // 선택한 만큼 빼기
        answer += 1 // 카운팅
    }
    return answer
}