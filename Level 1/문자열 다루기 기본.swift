func solution(_ s:String) -> Bool {
    // 단순풀이
    if s.count == 4 || s.count == 6 {
        if Int(s) != nil {
            return true
        }
    }
    return false
}