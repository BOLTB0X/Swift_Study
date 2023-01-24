import Foundation

func solution(_ numbers:[Int]) -> Int {
    // 10000 이므로 2중 for 문 이용 얘매
    // 그러므로 정렬 후 음수들의 곱을 대비해서
    // 끝쪽과 앞쪽 곱 결과를 비교해야함
    var numbers = numbers.sorted()
    return max(numbers[0] * numbers[1], numbers[numbers.count - 1] * numbers[numbers.count - 2])
}