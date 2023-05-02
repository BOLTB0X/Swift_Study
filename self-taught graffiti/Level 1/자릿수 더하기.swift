import Foundation

func solution(_ n:Int) -> Int{
    // 단순풀이
    return String(n).map{Int(String($0))!}.reduce(0, +)
}

func solution(_ n:Int) -> Int{
    // C언어 스탈
    var answer:Int = 0
    var n = n
    var tmp = Int(pow(10.0 ,Float(String(n).count)-1.0)) // 길이
    
    while tmp != 0 {
        answer += (n / tmp)
        n %= tmp
        tmp /= 10
    }
    return answer
}