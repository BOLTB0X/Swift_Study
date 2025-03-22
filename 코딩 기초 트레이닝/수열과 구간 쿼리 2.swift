import Foundation

func solution(_ arr:[Int], _ queries:[[Int]]) -> [Int] {
    var answer: [Int] = []
    var arr = arr
    
    for query in queries {
        let a = arr[query[0]...query[1]].filter { $0 > query[2]}.sorted()
        answer.append(a.isEmpty ? -1 : a[0])
    }
    return answer
}