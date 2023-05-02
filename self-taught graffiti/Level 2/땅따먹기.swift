import Foundation

func solution(_ land:[[Int]]) -> Int{
    var answer = 0
    
    var dp = land // dp 테이블 생성
    
    // 누적되는 식으로 진행되므로 행은 1부터 시작
    for i in 1..<land.count {
        // 열은 4로 고정
        for j in 0..<4 {
            for k in 0..<4 {
                // 같은 열 X
                if j==k {
                    continue
                } 
                // 현재 dp위치화 바로 위칸의 열들을 더해보며 최댓값을 찾음
                dp[i][j] = max(dp[i][j], dp[i-1][k]+land[i][j])
            }
        }
    }
    

    return dp.last!.max()!
}