import Foundation

func solution(_ n:Int) -> [Int] {
    var answer: [Int] = []
    
    // 소인수 분해이므로 2부터 시작
    for i in 2...n {
        // 나눠어떨이지는 수가 하나로 퉁 치는 것이므로
        if n % i == 0 && !answer.contains(where: { i % $0 == 0} ) {
            answer.append(i) // answer 배열 안에 나눠떨어지는 수와 배열 안 원소가 나눠 떨어지는 수가 없을때 정답에 삽입
        }
    } 
    return answer
}