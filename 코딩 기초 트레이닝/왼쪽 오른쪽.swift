import Foundation

func solution(_ str_list:[String]) -> [String] {
    var arr = str_list
    
    for i in 0..<arr.count {
        if arr[i] == "l" {
            if i == 0 {
                return []
            }
            return Array(arr[...(i - 1)])
        } else if arr[i] == "r" {
            if i == arr.count - 1 {
                return []
            }
            return Array(arr[(i + 1)...])
        }
    }
    return []
}