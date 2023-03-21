func solution(_ s:String) -> String {
    var s = s.split(separator: " ")
    var arr:[Int] = [] // 잠시 담을 배열
    
    // 단순풀이
    for ss in s {
        guard let intNumber = Int(ss) else { return " "}
        arr.append(intNumber)
    }
    return "\(arr.min()!) \(arr.max()!)"
}