import Foundation

// 정답
var answer: Set<Int> = []

func isPrime(num: String) -> Bool {
    let transNum = Int(num)! // 변환
    
    if transNum < 4 { // 4이하일 경우
        return transNum == 1 ? false : true
    }

    for i in 2...Int(sqrt(Double(transNum))) {
        if transNum % i == 0 {
            return false
        }
    }

    return true
}

// DFS로 순열 구현
func DFS(array: [String], number: String, n: Int, level: Int) {
    // 탈출 조건
    if level == n && isPrime(num: number) == true {
        answer.append(Int(number)!) // 알아서 중복 제거
        return
    }

    // 배열 순회
    for i in 0..<array.count {
        var new_array = array // var로 교체
        let str = new_array.remove(at: i) // 제거와 제거한 무자
        DFS(array: new_array, number: "\(number)\(String(str))", n: n, level: level + 1)
    }
}

func solution(_ numbers:String) -> Int {
    let size = numbers.count
    let arr = numbers.map{String($0)} // 배열로 복사

    // 1부터 배열의 길이만큼
    // 돌려서 자리수에 해당하는 소수를 찾음
    for i in 1...size{
        DFS(array: arr, number: "", n: i, level: 0)
    }

    return answer.count
}