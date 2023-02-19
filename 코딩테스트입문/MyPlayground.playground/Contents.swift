import UIKit
var coke = 20

var array = [3, 10, 28]
var n = 20

var answer : [Int] = []
var p = [93,30,55]
var speeds = [1,30,5]

print(speeds.sorted(by: >))

while p.count > 0 {
    var cnt: Int = 0
    for i in 0..<speeds.count {
        p[i] += speeds[i] // 진도
    }
    
    while p.count > 0 && p[0] >= 100 {
        p.removeFirst()
        speeds.removeFirst()
        cnt += 1
    }
    
    if cnt > 0 {
        answer.append(cnt)
    }
}

print(answer)
