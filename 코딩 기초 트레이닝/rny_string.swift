import Foundation

func solution(_ rny_string:String) -> String {
    var arr = rny_string.map{String($0)}
    
    for i in 0..<arr.count {
        if arr[i] == "m" {
            arr[i] = "rn"
        }
    }
    return arr.joined()
}