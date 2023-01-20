import Foundation

func solution(_ numbers:String) -> Int64 {
    var answer : String  // 리턴할 문자열형 변수
    // 딕셔너리로 key에 단어, value에 문자형 숫자
    var dict: [String: String] = ["zero": "0","one": "1","two": "2","three": "3","four": "4","five": "5","six": "6","seven": "7","eight": "8","nine": "9"]
    
    answer = numbers
    // 반복문 이용
    for d in dict {
        // replacingOccurrences 이용
        // of가 with로 대체 된다.
        answer = answer.replacingOccurrences(of: d.key, with: d.value)
    }
    return Int64(answer)! // 타입변환 후 반환
}