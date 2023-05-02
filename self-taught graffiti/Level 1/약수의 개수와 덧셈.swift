import Foundation

func solution(_ left:Int, _ right:Int) -> Int {
    var answer: Int = 0 // 정답
    
    for i in left...right {
        var check = getMeasureCount(number: i)
        // 짝수이면
        if check % 2 == 0 {
            answer += i
        } else { // 홀수이면
            answer -= i
        }
    }
    return answer
}

// 약수 갯수 반환
func getMeasureCount(number: Int) -> Int {
    var ret: Int = 0
    
    for i in 1...number {
        // 나눠떨어지는 경우
        if number % i == 0 {
            ret += 1 // 카운트
        }
    }
    return ret
}