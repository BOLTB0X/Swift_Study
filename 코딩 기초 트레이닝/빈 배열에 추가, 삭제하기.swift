import Foundation

func solution(_ arr:[Int], _ flag:[Bool]) -> [Int] {
    var answer:[Int] = []
    
    for i in 0..<flag.count {
        if flag[i] { //  flag[i]가 true라면 
            for _ in 0..<arr[i]*2 { // X의 뒤에 arr[i]를 arr[i] × 2 번 추가
                answer.append(arr[i])
            }
        } else { // flag[i]가 false라면 
            if answer.isEmpty {
                continue
            }
            for _ in 0..<arr[i] { //  false라면 X에서 마지막 arr[i]개의 원소를 제거
                answer = answer.dropLast()
            }
        }
    }
    return answer
}