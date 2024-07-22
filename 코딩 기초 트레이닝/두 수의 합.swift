import Foundation

func solution(_ a:String, _ b:String) -> String {
    var answer = ""
    var carry = 0
    var aIndex = a.count - 1
    var bIndex = b.count - 1
    
    while aIndex >= 0 || bIndex >= 0 || carry > 0 {
        let digitA = aIndex >= 0 ? Int(String(a[a.index(a.startIndex, offsetBy: aIndex)])) ?? 0 : 0
        let digitB = bIndex >= 0 ? Int(String(b[b.index(b.startIndex, offsetBy: bIndex)])) ?? 0 : 0
        
        let sum = digitA + digitB + carry
        let digit = sum % 10
        carry = sum / 10 // 이 올림떄문에 계속해서 해야함
        
        answer = "\(digit)\(answer)"
        
        aIndex -= 1
        bIndex -= 1
    }
    
    return answer
}