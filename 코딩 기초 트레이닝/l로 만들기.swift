import Foundation

func solution(_ myString:String) -> String {
    var arr = myString.map{String($0)} // 편의상
    let alp = "abcdefghijklmnopqrstuvwxyz".map{String($0)}
    
    for i in arr.indices {
        if 11 > alp.firstIndex(of: arr[i])! {
            arr[i] = "l"
        }
    }
    
    return arr.joined()
}