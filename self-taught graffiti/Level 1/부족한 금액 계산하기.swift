import Foundation

func solution(_ price:Int, _ money:Int, _ count:Int) -> Int64{
    var curMoney:Int64 = 0 // 현재 돈
    
    // 총 비용 계산
    for i in 1...count {
        curMoney += Int64(i*price)
    }
    
    // 문제 조건에 맞게 리턴
    return curMoney - Int64(money) > 0 ? curMoney - Int64(money) : 0
}