import Foundation

// 아메 4500
// 라테 5000
// 메뉴만 적은 건 아이스
// 아무거나는 아아
// 아이스나 뜨거운 거는 가격 동일

func solution(_ order:[String]) -> Int {
    order.reduce(0) { 
        $0 + ($1.contains("americano") ? 4500 : $1.contains("cafelatte") ? 5000 : 4500)
    }
}