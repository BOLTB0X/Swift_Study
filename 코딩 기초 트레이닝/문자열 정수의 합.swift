import Foundation

func solution(_ num_str:String) -> Int {
    var answer:Int = 0
    for n in num_str {
        answer += Int(String(n))!
    }
    return answer
}