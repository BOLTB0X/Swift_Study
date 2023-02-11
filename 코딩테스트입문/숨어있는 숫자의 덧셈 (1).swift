import Foundation

func solution(_ my_string:String) -> Int {
    // 문자열에 filter을 걸어 숨어잇는 숫자를 걸러냄
    // map으로 Int형으로 강제추출
    // 그 후 reduce로 합을 반환
    return my_string.filter{ $0.isNumber}.map{Int(String($0))!}.reduce(0,+)
}