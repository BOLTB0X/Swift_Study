import Foundation

func solution(_ strlist:[String]) -> [Int] {
    var answer : Array<Int> = [Int]()
    
    // 반복문 이용
    for str in strlist {
        answer.append(str.count) // 길이
    }
    return answer
}

// 고차함수 이용 풀이
import Foundation

func solution(_ strlist:[String]) -> [Int] {
    // map 이용
    // 배열에 map을 이용하면 한개의 원소씩 맵핑해줌
    var answer:[Int] = strlist.map { $0.count }
    return answer
}