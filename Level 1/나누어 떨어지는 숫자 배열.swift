func solution(_ arr:[Int], _ divisor:Int) -> [Int] {
    // filter 이용
    var newArr = arr.filter {$0%divisor == 0}
    
    // 없다면
    if newArr.count == 0 {
        return [-1]
    } else { // 정렬해서 반환
        return newArr.sorted()
    }
}