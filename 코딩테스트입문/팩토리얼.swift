import Foundation

func solution(_ n:Int) -> Int {
    var number = 1 // 증가될 수
    var facValue = 1 // 팩토리얼 변수
    
    // 초과되기 전까지 반복
    // 즉 facValue값이 n을 따라잡도록 한다
    while facValue <= n {
        facValue *= number 
        number += 1 // 증가
    }
    
    // 반목문이 끝난 경우
    // facValue값이 무조건 목표를 초과한 경우이다
    // while문은 항상 1을 초과하기에
    // facValue가 n과 같다면 -1, 초과하면 -2
    return facValue == n ? number - 1 : number - 2
}