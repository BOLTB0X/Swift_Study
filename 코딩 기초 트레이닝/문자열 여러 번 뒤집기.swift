import Foundation

func solution(_ my_string:String, _ queries:[[Int]]) -> String {
    var arr = my_string.map{String($0)} // 편의
    
    for q in queries {
        // 거꾸로 뒤집을 배열 원소들 임시배열에 넣어줌
        let tmpArr = Array(arr[q[0]...q[1]]).reversed()
        arr.replaceSubrange(q[0]...q[1], with: tmpArr)
    }
    return arr.joined()
}