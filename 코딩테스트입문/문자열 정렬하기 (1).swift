import Foundation

func solution(_ my_string:String) -> [Int] {
    var answer : [Int] = []
    
    for s in my_string {
        // 정수이면 삽입 아니면 패스
        guard let number = Int(String(s)) else { continue }
        answer.append(number)
    }
    
    answer.sort() // 오름차순 정렬
    return answer
}