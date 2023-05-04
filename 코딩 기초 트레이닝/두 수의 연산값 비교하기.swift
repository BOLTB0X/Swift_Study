import Foundation

func solution(_ a:Int, _ b:Int) -> Int {
    return Int("\(a)\(b)")! > 2*a*b ? Int("\(a)\(b)")! : 2*a*b
}