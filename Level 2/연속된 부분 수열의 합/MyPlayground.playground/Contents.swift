import Foundation

let sequence1 = [1, 2, 3, 4, 5]
let sequence2 = [1, 1, 1, 2, 3, 4, 5]
let sequence3 = [2, 2, 2, 2, 2]
let k1 = 7
let k2 = 5
let k3 = 5

func solution(_ sequence:[Int], _ k:Int) -> [Int] {
    var answer:[Int] = []
    var candiArr:[[Int]] = []
    var start:Int = 0, end:Int = -1, tot:Int = 0
    
    // 투 포인터
    while true {
        print("\(start) \(end)")
        if k > tot {
            end += 1
            if end == sequence.count {
                break
            }
            tot += sequence[end]
        } else {
            if k == tot {
                candiArr.append([start, end])
            }
            tot -= sequence[start]
            start += 1
            if start == sequence.count {
                break
            }
        }
    }
    
    let sortedArr = candiArr.sorted{abs($0[0]-$0[1]) < abs($1[0]-$1[1])}
    answer.append(sortedArr.first![0])
    answer.append(sortedArr.first![1])
    return answer
}

print(solution(sequence1, k1))
