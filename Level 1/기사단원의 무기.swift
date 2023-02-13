import Foundation

func solution(_ number:Int, _ limit:Int, _ power:Int) -> Int {
    var answer: Int = 0
    var divisor: [Int] = Array(repeating: 0, count: number + 1)
    
    // 약수 체크
    for i in 1...number {
        for j in 1...(number/i){
            divisor[i*j] += 1
        }
    }
    
    // 체크
    for i in divisor.enumerated() {
       if i.1 > limit { // 제한보다 크다면
       answer += power
       } else { // 그 외
           answer += i.1
       }
    }
    
    return answer
}