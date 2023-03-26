import Foundation

var prices = [1, 2, 3, 2, 3]

var answer:[Int] = []
var que = prices // 큐 로

while que.count > 0 {
    var cur = que.first!
    que.removeFirst()
    var cnt:Int = 0
    
    for q in que {
        cnt += 1
        if cur > q {
            break;
        }
    }
    
    answer.append(cnt)
}
print(answer)
