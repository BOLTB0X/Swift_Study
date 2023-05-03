import Foundation

func solution(_ my_string:String, _ overwrite_string:String, _ s:Int) -> String {
    let startIdx = my_string.index(my_string.startIndex, offsetBy: 0) // 기존
    let endIdx = my_string.index(my_string.endIndex, offsetBy: 0)
    // 새로 끼울 자리
    let newStartIdx = my_string.index(my_string.startIndex, offsetBy: s)
    let newEndIdx = my_string.index(my_string.startIndex, offsetBy: s + overwrite_string.count)

    return "\(my_string[startIdx..<newStartIdx])\(overwrite_string)\(my_string[newEndIdx..<endIdx])"
}

func solution(_ my_string:String, _ overwrite_string:String, _ s:Int) -> String {
    var arr1 = my_string.map{String($0)}
    var arr2 = overwrite_string.map{String($0)}
    var idx = 0
    for i in 0..<arr2.count {
        arr1[s+i] = arr2[idx]
        idx += 1
    }
    return arr1.joined()
}
