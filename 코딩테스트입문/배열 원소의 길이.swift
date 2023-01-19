import Foundation

func solution(_ strlist:[String]) -> [Int] {
    var answer : Array<Int> = [Int]()
    
    // 반복문 이용
    for str in strlist {
        answer.append(str.count) // 길이
    }
    return answer
}