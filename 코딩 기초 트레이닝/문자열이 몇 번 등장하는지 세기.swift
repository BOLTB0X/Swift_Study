import Foundation

func solution(_ myString:String, _ pat:String) -> Int {
    var answer:Int = 0
    var arr = myString.map{ String($0) }
    
    for i in 0...(myString.count - pat.count) {
        let subStr = arr[i..<i+pat.count].joined()
        
        if subStr == pat {
            answer += 1
        }
    }
    return answer
}