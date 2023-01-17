import Foundation

func solution(_ numbers:[Int]) -> Int {
    // 내림차순 정렬
    let numbers_arr = numbers.sorted(by : >)
    
    return numbers_arr[0] * numbers_arr[1]
}