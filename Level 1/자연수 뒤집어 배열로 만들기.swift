func solution(_ n:Int64) -> [Int] {
    // compactMap 이용
    // 컨테이너의 각 요소를 조건을 지정하여 호출할 때, nil 이 아닌 배열을 반환
    // func compactMap<ElementOfResult>(_ transform: (Self.Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult]
    return String(n).compactMap { Int(String($0)) }.reversed()
}