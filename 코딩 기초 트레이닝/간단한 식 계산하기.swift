import Foundation

func solution(_ binomial:String) -> Int {
    let arr = binomial.components(separatedBy: " ")
    
    if arr[1] == "+" {
        return Int(arr[0])!+Int(arr[2])!
    } else if arr[1] == "-" {
        return Int(arr[0])!-Int(arr[2])!
    }
    return  Int(arr[0])!*Int(arr[2])!
}