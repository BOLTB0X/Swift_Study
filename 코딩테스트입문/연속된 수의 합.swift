import Foundation

func solution(_ num:Int, _ total:Int) -> [Int] {
    // -합 부터 합까지 반복문 시작
    // total이 0일 경우도 고려
    for i in -(total+num)...total+num {
        var d: Int = i // 등차
        var tmp: [Int] = [] // 임시 배열
        for j in 0..<num { // 등차수열 항 갯수는 num
            tmp.append(d)
            d += 1
        }
        
        // 찾는 다면
        if tmp.reduce(0, +) == total {
            return tmp
        }
    }
    return []
}