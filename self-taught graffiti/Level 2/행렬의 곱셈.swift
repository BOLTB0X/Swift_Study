import Foundation

func solution(_ arr1:[[Int]], _ arr2:[[Int]]) -> [[Int]] {
    var answer:[[Int]] = Array(repeating: Array(repeating: 0, count: arr2[0].count), count: arr1.count)
    var arr1 = arr1 // 편의용
    var arr2 = arr2 // 편의용
    
    // 행렬 곱셈
    // 곱셈이 가능한 경우가 A의 열과 B의 행 길이가 맞아야함
    for i in 0..<answer.count {
        for j in 0..<answer[i].count {
            for k in 0..<arr1[0].count {
                // 기존 수학처럼 결과의 1행 1열 2행 1열 을 구하는 것이 아닌
                // 뒤에 곱해지는 행의 길이만큼 1행 1열에 더해지는 것을 다 더해주며 진행
                answer[i][j] += (arr1[i][k] * arr2[k][j])
            }
        }
    }
    
    return answer
}