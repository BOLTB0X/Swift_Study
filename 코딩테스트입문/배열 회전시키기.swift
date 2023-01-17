import Foundation

func solution(_ numbers:[Int], _ direction:String) -> [Int] {
    var answer = [Int]()
    
    // 오른쪽으로 회전
    if (direction == "right") {
        // -> 방향이므 마지막 원소를 제일 앞으로
        answer.append(numbers.last!)
        // 나머진 일반 순서대로
        for i in numbers {
            answer.append(i)
        }

        // for문으로 다 넣어 버렸으니 마지막 원소 삭제
        answer.removeLast()

    } else {
        answer = numbers // 배열 복사
        answer.append(numbers[0]) // 최상단을 뒤로
        answer.removeFirst() // 이동한 상단을 삭재
    }
    
    return answer
}