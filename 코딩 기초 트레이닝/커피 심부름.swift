import Foundation

func solution(_ order:[String]) -> Int {
    var answer:Int = 0
    // 아메 4500
    // 라테 5000
    // 메뉴만 적은 건 아이스
    // 아무거나는 아아
    // 아이스나 뜨거운 거는 가격 동일
    
    for o in order {
        if o.contains("americano") {
            answer += 4500
        } else if o.contains("cafelatte") {
            answer += 5000
        } else if o == "anything" {
            answer += 4500
        }
    }
    return answer
}