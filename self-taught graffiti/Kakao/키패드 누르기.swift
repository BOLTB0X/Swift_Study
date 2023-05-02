import Foundation

func solution(_ numbers:[Int], _ hand:String) -> String {
    var answer:String = ""
    
    // 키 패드 좌표로
    let keypadCoodi = [[3,1],[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]]
    var hand = (hand == "left") ? 0 : 1 // 손
    var curHand = [[3,0], [3,2]]  //왼손, 오른손 현재좌표

    for i in numbers {
        // 왼속인 경우
        if i == 1 || i == 4 || i == 7 {
            curHand[0] = keypadCoodi[i]
            answer.append("L")
        } else if i == 3 || i == 6 || i == 9 { // 오른손 인경우
            curHand[1] = keypadCoodi[i]
            answer.append("R")
        } else { // 그외의 경우
            // 가까운 손이 움직이니 거리를 알아야함
            // 현재 손 위치와 해당 키패드 들의 절대값들을 더해주면 됌 
            let leftDiff = abs(curHand[0][0]-keypadCoodi[i][0]) + abs(curHand[0][1]-keypadCoodi[i][1])  
            let rightDiff = abs(curHand[1][0]-keypadCoodi[i][0]) + abs(curHand[1][1]-keypadCoodi[i][1])

            // 재수없게 같은 경우이면
            if leftDiff == rightDiff {
                curHand[hand] = keypadCoodi[i]
                answer.append((hand == 0) ? "L" : "R")
            } else if leftDiff < rightDiff { // 오른쪽 거리가 크니 왼손을 써야함
                curHand[0] = keypadCoodi[i]
                answer.append("L")
            } else { // 왼쪽 거리가 크니 오른손을 써야함
                curHand[1] = keypadCoodi[i]
                answer.append("R")
            } 
        }
    }
    return answer
}