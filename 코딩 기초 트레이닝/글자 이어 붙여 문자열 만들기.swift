import Foundation

func solution(_ my_string:String, _ index_list:[Int]) -> String {
    var answer:String = ""
    
    var arr = my_string.map{String($0)} // 배열로 변환
    
    for i in index_list {
        answer += arr[i]
    }
    
    return answer
}