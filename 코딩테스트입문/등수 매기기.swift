import Foundation

func solution(_ score:[[Int]]) -> [Int] {
    // 기존 점수 배열들의 합을 구하고 오름차순으로 정렬
    var totalArr = score.map{ $0.reduce(0,+) }.sorted(by : >)
    // firstIndex(of:) 는 배열의 앞에서부터 조회해서 첫번째 일치하는 값의 index를 반환
    // lastIndex(of:) 는 배열의 뒤에서부터 조회해서 첫번째 일치하는 값의 index를 반환
    // map이용 -> reduce을 기준으로 firstIndex 
    return score.map{ totalArr.firstIndex(of: $0.reduce(0,+))! + 1 }
}