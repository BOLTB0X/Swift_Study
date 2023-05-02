import Foundation

func solution(_ n:Int, _ m:Int, _ section:[Int]) -> Int {
    var answer:Int = 0
    var currentPro:Int = 0 // 현재 진행상태
    
    for i in 0..<section.count {
        // 한 번 밀 때 넘어간 경우
        if section[i] < currentPro {
            continue
        }
        
        answer += 1 // 카운트
        maxIdx = section[i]+m // 밀어버린 위치 변경
    }
    return answer
}