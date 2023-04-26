import Foundation

func solution(_ my_string:String, _ alp:String) -> String {
    var arr = my_string.map{String($0)}
    
    for i in 0..<arr.count {
        if arr[i] == alp {
            arr[i] = arr[i].uppercased()
        }
    }
    return arr.joined()

    // return my_string.map { String($0) == alp ? $0.uppercased() : $0.lowercased() }.joined()
    // return myString.replacingOccurrences(of: alp, with: alp.uppercased())
}