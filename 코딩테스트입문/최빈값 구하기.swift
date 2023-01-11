import Foundation

func solution(_ array:[Int]) -> Int {
    var answer = 0
    var dict = [Int : Int] ()
    var maxNum = 0
    var cnt = 0

    // 딕셔너리
    for i in array {
        // key값이 존재하면
        if dict.contains {$0.key == i} {
            dict[i]! += 1
        }
        else {
            // 딕셔너리 key 추가
            dict[i] = 1
        }
    }

    for (key, value) in dict {
        if value == dict.values.max() {
            cnt += 1
            maxNum = key
        }
    }

    answer = cnt == 1 ? maxNum : -1
    return answer
}