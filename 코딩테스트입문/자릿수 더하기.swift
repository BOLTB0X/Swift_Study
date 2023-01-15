import Foundation

func solution(_ n:Int) -> Int {
    var answer = 0
    let str = String(n).map{String($0)} // 문자열 변환
    
    for i in 0..<str.count {
        answer += Int(str[i])!
    }
    
    return answer;
}