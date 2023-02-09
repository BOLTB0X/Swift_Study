import Foundation

func solution(_ my_string:String) -> String {
    // 문자열인 경우는 components를 주로
    return my_string.components(separatedBy: ["a", "e", "i", "o", "u"]).joined()
}