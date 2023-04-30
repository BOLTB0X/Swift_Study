import Foundation

func solution(_ my_string:String, _ is_suffix:String) -> Int {
    var arr:[String] = [] // 접미사 배열
    
    for i in 0..<my_string.count { // 뒤는 그대로, 앞에서 하나씩 잘라서 확인
        let idx = my_string.index(my_string.startIndex, offsetBy:i)
        arr.append(String(my_string[idx..<my_string.endIndex]))
    }
    
    return arr.contains(is_suffix) ? 1 : 0
}