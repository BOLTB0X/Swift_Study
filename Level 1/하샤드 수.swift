func solution(_ x:Int) -> Bool {
    // 단순풀이
    // compactMap 이용
    var digit = String(x).compactMap{Int(String($0))}.reduce(0,+)
    return x % digit == 0 ? true : false
}