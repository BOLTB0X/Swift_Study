import Foundation

func solution(_ n:Int) -> Int {
    var answer:Int = 0
    // 단순풀이
    let firstNumber: Int = String(n, radix: 2).map{String($0)}.filter{$0 == "1"}.count
    for i in n+1...1000000 {
        var tmp = String(i, radix: 2).map{String($0)}.filter{$0 == "1"}.count
        
        // 탈출 조건
        if firstNumber == tmp {
            answer = i
            break;
        }
    }
    return answer
}