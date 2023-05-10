import Foundation

func solution(_ intStrs:[String], _ k:Int, _ s:Int, _ l:Int) -> [Int] {
    var answer:[Int] = []
    
    for str in intStrs {
        var arr = str.map{String($0)}
        
        var slideStr = Array(arr[s..<s+l]).joined()
        if Int(slideStr)! > k {
            answer.append(Int(slideStr)!)
        }
    } 
    return answer
    // return intStrs.map { Int(String(Array($0)[s..<(s+l)]))! }.filter { $0 > k }

}