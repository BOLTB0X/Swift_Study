import Foundation

func solution(_ my_string:String) -> [Int] {
    // 고차함수 이용
    // 먼저 filter로 숫자를 걸러내고
    // map으로 Int형으로 반환해줌
    // 기본 문자열형이 쪼개지므로 String으로 변환하고 Int에서 강제추출
    return my_string.filter{ $0.isNumber }.map{ Int(String($0))! }.sorted()
}