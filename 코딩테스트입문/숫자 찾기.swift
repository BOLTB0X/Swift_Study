import Foundation

func solution(_ num:Int, _ k:Int) -> Int {
    // 편의를 위해 문자열로 변경
    // contains을 이용하여 특정문자가 존재하는 지 체크
    // 참이면 firstIndex로 인덱스 + 1로 반환
    // 아니면 -1
    return String(num).contains(Character(String(k))) ? Array(String(num)).firstIndex(of: Character(String(k)))! + 1 : -1
}