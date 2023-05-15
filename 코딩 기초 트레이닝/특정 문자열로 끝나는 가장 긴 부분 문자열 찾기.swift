import Foundation

func solution(_ myString:String, _ pat:String) -> String {
    var str = myString
    
    while str.suffix(pat.count) != pat {
        str = String(str.dropLast()) // Array 를 변경하지는 않고, 마지막 n 개를 제외한 원소들 반환
    }
    return str
}