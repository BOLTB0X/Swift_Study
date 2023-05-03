import Foundation

func solution(_ n_str:String) -> String {
    if n_str.first! != "0" { // 문제 조건 상
        return n_str
    } else {
        var arr = n_str.map{String($0)} // 편의로
        for i in 1..<arr.count {
            if arr[i] != "0" { // 0이 아닌거 발견 시 즉시
                return arr[i..<arr.count].joined() 
            }
        }
    }
    return ""
}