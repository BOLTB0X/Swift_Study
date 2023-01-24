import Foundation

func solution(_ s:String) -> String {
    var answer : String = ""
    var dict : [Character : Int] = [:] // 딕셔너리

    for alp in s {
        // 딕셔너리 안에 key 값이 존재한다면
        if let value = dict[alp] { 
            dict[alp]! += 1 // 카운트
        } else { // 만들어줌
            dict[alp] = 1
        }
    }
    
    // 한 번 등장한 알파벳들을 정답 문자형에 넣기
    for d in dict where d.value == 1 {
        answer += String(d.key)
    }

    return String(answer.sorted{ $0 < $1 }) // 정렬 
}