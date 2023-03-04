import UIKit

var N:Int = 5
var stages: [Int] = [2, 1, 2, 6, 2, 4, 3, 3]

// 인덱스-> 스테이지, 값 진행자 수
    var stageFail = Array(repeating: 0, count: N+2)
    var stageSuccess = Array(repeating: 0, count: N+2)
    
    // 진행자들 카운팅
    for i in 0..<stages.count {
        stageFail[stages[i]] += 1
    }
    
    var tmp:Int = stages.count // 총 인원
    for i in 1..<N+2 {
        stageSuccess[i] = tmp - stageFail[i]
        tmp -= stageFail[i]
    }

print(stageFail)
print(stageSuccess)

var failPercents: Dictionary = [Int: Double]()

for i in 1..<N+1 {
    let failPer = Double(stageFail[i]) / Double(stageSuccess[i])
    failPercents[i] = failPer
}

// 정렬
let tmpfailPercents = failPercents.sorted(by: <).sorted(by: {$0.1 > $1.1})

print(failPercents)

var answer = tmpfailPercents.map {$0.key}
print(answer)
