import Foundation

func solution(_ s:String) -> Bool {
    var ans:Bool = false
    
    // 소문자로 변환하고 p, y개수를 카운트
    var cnt1 = s.lowercased().filter {$0 == "p"}.count 
    var cnt2 = s.lowercased().filter {$0 == "y"}.count
    
    // 문제조건
    ans = cnt1 == cnt2 ? true : false
    return ans
}