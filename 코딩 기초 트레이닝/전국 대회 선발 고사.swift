import Foundation

func solution(_ rank:[Int], _ attendance:[Bool]) -> Int {
    var answer:[Int] = []
    var dict = [Int: Int]()
    
    // 딕셔너리 생성
    for i in 0..<rank.count {
        if attendance[i] {
            dict[rank[i]] = i
        }
    }
    
    let newDict = dict.sorted { $0.0 < $1.0 }
    
    for n in newDict {
        if answer.count == 3 {
            break
        }
        answer.append(n.1)
        
    }
    //     let stu: [Int] = rank.enumerated()
    //     .filter { attendance[$0.offset] }
    //     .sorted(by: { $0.element < $1.element })
    //     .map { $0.offset }
    // return stu[0] * 10000 + stu[1] * 100 + stu[2]
    return answer[0] * 10000 + 100 * answer[1] + answer[2]
}