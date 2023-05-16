import Foundation

func solution(_ picture:[String], _ k:Int) -> [String] {
    var answer:[String] = []
    
    for i in 0..<picture.count {
        var tmp = String()
        for j in picture[i] {
            for _ in 0..<k {
                tmp += String(j)
            }
        }
        for _ in 0..<k {
            answer.append(tmp)
        }
    }
    return answer
}