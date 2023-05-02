func solution(_ n:Int64) -> Int64 {
    // compactMap 이용
    // 편의를 위해 문자열로 바꾸고 정렬
    // 그 다음 문자열로 다시 변환하고 Int64 강제추출
    return Int64(String(n).compactMap{String($0)}.sorted(by: >).joined(separator : ""))!
}