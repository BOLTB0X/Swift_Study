// https://school.programmers.co.kr/learn/courses/30/lessons/181836
import Foundation

func solution(_ picture:[String], _ k:Int) -> [String] {
    var answer: [String] = []
    
    for pic in picture {
        var tempInsertString: String = ""
        for p in pic {
            var tempString: String = ""
            for _ in 0..<k {
                tempString.append(p)
            }
            tempInsertString += tempString
        }
        for _ in 0..<k { 
            answer.append(tempInsertString)
        }
    }
    return answer
}