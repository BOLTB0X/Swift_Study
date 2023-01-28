import Foundation

func solution(_ polynomial:String) -> String {
    var Arr = polynomial.components(separatedBy: " + ")
    var xnum : Int = 0
    var num : Int = 0
    
    for A in Arr {
        // x항인 경우
        if A.contains("x") {
            // 그냥 1인 경우
            if A == "x" {
                xnum += 1
            } else { // 2 이상인 경우
                var tmp = A 
                tmp.removeLast() // x 제거
                xnum += Int(tmp)! // 상수만 더해줌
            }
        } else { // 상수항인 경우
            num += Int(A)!
        }
    }
    
    if xnum == 0 && num == 0 {
        return "0"
    }
    else if xnum == 0 && num != 0 {
        return "\(num)"
    }
    else if xnum != 0 && num == 0 {
        if xnum == 1 {
            return "x"
        } else {
            return "\(xnum)x"
        }
    }
    return xnum != 1 ? "\(xnum)x + \(num)" : "x + \(num)"
}