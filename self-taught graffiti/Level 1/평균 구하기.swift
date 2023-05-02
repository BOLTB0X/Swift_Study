 func solution(_ arr:[Int]) -> Double {
    // 단순 풀이
    return Double(arr.reduce(0,+)) / Double(arr.count)
}