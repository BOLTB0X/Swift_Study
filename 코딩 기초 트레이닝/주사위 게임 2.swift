import Foundation

func solution(_ a:Int, _ b:Int, _ c:Int) -> Int {
    if a == b && b == c && a == c {
        return (a+b+c)*(Int(pow(Double(a),3)) + Int(pow(Double(b),3)) + Int(pow(Double(c),3)))*(Int(pow(Double(a),2)) + Int(pow(Double(b),2)) + Int(pow(Double(c),2)))
    } else if a != b && b != c && a != c {
        return a+b+c
    }
    return (a+b+c)*(Int(pow(Double(a),2)) + Int(pow(Double(b),2)) + Int(pow(Double(c),2)))
}