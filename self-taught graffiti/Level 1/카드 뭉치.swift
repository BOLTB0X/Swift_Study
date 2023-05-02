import Foundation

func solution(_ cards1:[String], _ cards2:[String], _ goal:[String]) -> String {
    var answer:String = "Yes"
    var idx1 = 0, idx2 = 0 // 문제조건이 단어들이 순차적으로 나와야함
    
    // 그리디
    for i in 0..<goal.count {
        // 카드 뭉치1 이 다 쓰지 않고 같은 경우 
        if (idx1 < cards1.count) && (goal[i] == cards1[idx1]) {
            idx1 += 1
            // 카드 뭉치2가 다 쓰지 않고 같은 경우
        } else if (idx2 < cards2.count) && (goal[i] == cards2[idx2]) {
            idx2 += 1
        } else { // 안되는 것
            answer = "No"
            break
        }
    }
    return answer
}