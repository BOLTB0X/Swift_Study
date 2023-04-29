import Foundation

func solution(_ my_string: String, _ is_prefix: String) -> Int {
    var arr:[String] = []
    
    // 직접 접두사를 만들어줌
    for i in 1...my_string.count {
        let idx = my_string.index(my_string.startIndex, offsetBy: i)
        arr.append(String(my_string[..<idx]))
    }
    return arr.contains(is_prefix) ? 1 : 0
}