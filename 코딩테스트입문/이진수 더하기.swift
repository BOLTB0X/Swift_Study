import Foundation

func solution(_ bin1:String, _ bin2:String) -> String {
    // radix 이용
    return String(Int(bin1, radix: 2)! + Int(bin2, radix: 2)!, radix: 2)
}