import Foundation

func solution(_ a:Int, _ d:Int, _ included:[Bool]) -> Int {
    var tmp:Int = a
    var answer:Int = included[0] ? a : 0
    
    for i in 1..<included.count {
        tmp += d
        
        if included[i] {
            answer += tmp
        }
    }
    
    return answer
    // return (0..<included.count).reduce(0) { included[$1] ? $0 + a + d * $1 : $0 } 

}