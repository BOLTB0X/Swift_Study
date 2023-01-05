import Foundation

func solution(_ s1:[String], _ s2:[String]) -> Int {
    var answer = 0
    for tmp_s1 in s1 {
        for tmp_s2 in s2 {
            if tmp_s1 == tmp_s2 {
                answer += 1
            }
        }
    }
    return answer
}