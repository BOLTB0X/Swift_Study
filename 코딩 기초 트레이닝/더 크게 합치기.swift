import Foundation

func solution(_ a:Int, _ b:Int) -> Int {
    return Int("\(a)\(b)" > "\(b)\(a)" ? "\(a)\(b)" : "\(b)\(a)")!
}