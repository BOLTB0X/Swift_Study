func solution(_ s:String) -> String {
    // 단순풀이
    return s.sorted(by: >).map {String($0)}.joined()
}