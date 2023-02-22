func solution(_ strings:[String], _ n:Int) -> [String] {
    // 정렬 조건을 n번째 글자 기준으로 오름차순
     return strings.sorted { Array($0)[n] == Array($1)[n] ? $0 < $1 : Array($0)[n] < Array($1)[n] }
}