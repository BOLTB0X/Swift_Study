// https://school.programmers.co.kr/learn/courses/30/lessons/181858
import Foundation

func solution(_ arr:[Int], _ k:Int) -> [Int] {
    var answer: [Int] = []
    
    for element in arr {
        if answer.count == k { break }
        if answer.contains(element) { continue }
        answer.append(element)
    }
    
    while answer.count < k {
        answer.append(-1)
    }
    return answer
}