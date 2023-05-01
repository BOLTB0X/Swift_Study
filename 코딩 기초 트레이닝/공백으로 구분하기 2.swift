import Foundation

func solution(_ my_string:String) -> [String] {
    // components 로 나눌라면
    // 공백이 두개 이상이면 필터로 없애줘야함
    return my_string.components(separatedBy: " ").filter{!$0.isEmpty}
}