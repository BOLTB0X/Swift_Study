import Foundation

func solution(_ myString:String, _ pat:String) -> Int {
    var arr = myString.map{ String($0) == "A" ? "B" : "A" }
    return arr.joined().contains(pat) ? 1 : 0
}