import Foundation

func solution(_ my_string:String, _ letter:String) -> String {
    // components 이용
    // joined로 합쳐줌
    my_string.components(separatedBy: letter).joined()
}