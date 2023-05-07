import Foundation

func solution(_ myString:String) -> [Int] {
    var answer:[Int] = []
    var arr = myString.map{ String($0)} // 편의
    var cnt:Int = 0
    
    for i in 0..<arr.count {
        if arr[i] == "x" {
            answer.append(cnt)
            cnt = 0 
        } else {
            cnt += 1
        }
    } 
    answer.append(cnt)
    return answer
}