import Foundation

func solution(_ strArr:[String]) -> Int {
    var answer:Int = Int.min
    var len:Int = Int.min
    
    for i in 0..<strArr.count {
        if strArr[i].count > len {
            len = strArr[i].count
        }
    }
    
    for i in 1...len {
        let tmp = strArr.filter{$0.count == i}
        answer = max(tmp.count, answer)
    }
    
    return answer
}