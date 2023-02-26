func solution(_ arr1:[[Int]], _ arr2:[[Int]]) -> [[Int]] {
    // 단순 풀이
    var arr1 = arr1
    var arr2 = arr2
    
    for i in 0..<arr1.count {
        for j in 0..<arr1[i].count {
            arr1[i][j] += arr2[i][j]
        }
    }
    return arr1
}