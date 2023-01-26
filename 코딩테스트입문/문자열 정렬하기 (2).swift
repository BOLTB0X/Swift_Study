import Foundation

func solution(_ my_string:String) -> String {
    // lowecased로 대문자를 소문자로 변환
    // sorted을 이용하여 정렬
    // 반환을 맞춰줌
    String(my_string.lowercased().sorted())
}