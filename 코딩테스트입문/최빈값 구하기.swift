import Foundation

func solution(_ array:[Int]) -> Int {
    var dict : [Int : Int] = [:] // 편의를 위한 딕셔너리 이용
    var maxKey : Int = 0 // 가장 많이 나온 원소
    var cnt : Int = 0 // 마지막 리턴 체크를 위해 선언
    
    // 배열 원소를 순회하며
    for a in array {
        // 딕셔너리 안에 원소가 딕셔너리의 key로 존재한다면
        if dict.contains{$0.key == a} {
            dict[a]! += 1 // 카운트
        } else { // 없다면
            dict[a] = 1 // 1로 생성
        }
    }
    
    // 딕셔너리를 순회하며 최빈값 체크
    for (key, value) in dict {
        // 해당 value 가 딕셔너리 내 최댓값이면
        if value == dict.values.max() {
            maxKey = key
            cnt += 1 
        }
    }
    
    // 최빈값이 하나면 maxKey
    // 아니면 -1
    return cnt == 1 ? maxKey : -1
}