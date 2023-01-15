import Foundation

func solution(_ array:[Int]) -> Int {
    var dict: [Int : Int] = [:] // key = 원소 : value = 빈도수 
    var maxKey = 0 // 키값을 리턴해야 하므로 선언
    var cnt = 0 // 중복 방지용
    
    for ele in array {
        // 딕셔너리 안에 key 값이 존재하면
        if dict.contains{$0.key == ele} {
            dict[ele]! += 1 // 카운트
        } else { // 없다면
            dict[ele] = 1 // 만들어줌
        }
    }
    
    for (key, value) in dict {
        // 현재 값이 딕셔너리 벨류중 중에 최댓값이 면
        if value == dict.values.max() {
            cnt += 1 // 카운트
            maxKey = key // 키값 교체
        }
    }
    
    // 중복이 아니면 maxKey, 맞으면 -1
    return cnt == 1 ? maxKey : -1
}