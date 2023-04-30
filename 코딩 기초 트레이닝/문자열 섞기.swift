import Foundation

func solution(_ str1:String, _ str2:String) -> String {
    var answer:String = ""
    let str1 = str1.map{ String($0) }
    let str2 = str2.map{ String($0) }
    var idx1 = 0
    var idx2 = 0
    
    for i in 0..<(str1.count*2) {
        if i % 2 == 0 {
            answer += str1[idx1]
            idx1 += 1
        } else {
            answer += str2[idx2]
            idx2 += 1
        }
    }
    
    return answer
    //  return zip(str1, str2).map { String($0) + String($1) }.joined()
}