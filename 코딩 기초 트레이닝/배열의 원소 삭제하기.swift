// https://school.programmers.co.kr/learn/courses/30/lessons/181844
import Foundation

func solution(_ arr:[Int], _ delete_list:[Int]) -> [Int] {
    var answer:[Int] = arr
    
    for element in delete_list {
        if let idx = answer.firstIndex(of: element), answer.contains(element) {
            answer.remove(at: idx)
        }
    }
    
    return answer
    // arr.filter { !delete_list.contains($0) }
}