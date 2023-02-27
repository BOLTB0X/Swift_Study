import Foundation

func solution(_ d:[Int], _ budget:Int) -> Int {
    var answer:Int = 0
    var d:[Int] = d.sorted() // 편의용
    var tot:Int = 0
    
    // d의 총합이 예산보다 작거나 같다면
    if d.reduce(0,+) <= budget {
        return d.count
    }
    
    // 이 문제의 핵심은 오름차순 정렬
    // 최대한 많이 선택해야 하므로
    // 가장 작은 것 부터 집으면서 진행하다
    // 초과되는 순간에 멈춰여함
    for i in 0..<d.count {
        tot += d[i]
        // 범위 안이 면
        if tot <= budget {
            answer += 1
        } else { // 초과되는 순간
            break
        }
    }
    return answer
}