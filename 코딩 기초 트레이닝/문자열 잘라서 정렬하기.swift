import Foundation

func solution(_ myString:String) -> [String] {    
 var answer:[String] = []
    var tmp:String = ""
    
    for m in myString {
        if m == "x" {
            if !tmp.isEmpty {
                answer.append(tmp)
                tmp = ""
            }
        } else {
            tmp.append(m)
        }
    }
    
    if !tmp.isEmpty {
        answer.append(tmp)
    }
    
    return answer.sorted()
    // return myString.split{$0=="x"}.map{String($0)}.sorted()
}