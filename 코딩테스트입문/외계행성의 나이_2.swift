import Foundation

func solution(_ age:Int) -> String {
    // UnicodeScalar 정수 이용시 Uint8
    return String(age).map {
        String(UnicodeScalar(UInt8(Int(String($0))! + 97)))
    }.joined(separator: "")
}