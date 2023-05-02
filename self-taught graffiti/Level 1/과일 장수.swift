import Foundation

func solution(_ k:Int, _ m:Int, _ score:[Int]) -> Int {
    var answer:Int = 0
    var _score = score.sorted(by: >) // 편의용, 오름차순 정렬
    var idx:Int = m - 1 // m만큼 잘라서 가장 작은 걸 집기위해
    
    // 0 1 2 3 4 5 6 7 8 9 10 11 idx
    
    // [3 3 2 (2)] 1 1 1
    // [4 4 (4)] [4 4 (4)] [2 2 (2)] [2 1 (1)] 
    
    // 배열을 다 돌기 전까지
    while idx < _score.count {
        // 최저 사과 점수 * 한 상자에 담긴 사과 개수
        answer += _score[idx] * m
        idx += m // 루프가 도니 m만큼 땡김
    }

    return answer
}