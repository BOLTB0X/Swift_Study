// 시간초과
import Foundation

func solution(_ players:[String], _ callings:[String]) -> [String] {
    // 정답
    var answer:[String] = players
    
    // players는 등수 되로 정렬되어있음
    // callings에서 하나씩 될때 마다 앞과 swap
    for i in 0..<callings.count {
        let calledIndex = answer.firstIndex(of: callings[i])!
        //print(answer)
        // 경주 진행중 1등인 선수의 이름은 불리지 않습니다.
        if (calledIndex == 0) {
            continue
        }
        answer.swapAt(calledIndex-1, calledIndex)
    }
    return answer
}

// 정답
import Foundation

func solution(_ players:[String], _ callings:[String]) -> [String] {
    // 정답
    var answer:[String] = players
    var dict:[String:Int] = [:]
    var idx:Int = 0
    
    // 딕셔너리 이용
    for p in players {
        dict[p] = idx
        idx += 1
    }
    
    // players는 등수 되로 정렬되어있음
    // callings에서 하나씩 될때 마다 앞과 swap
    for c in callings {
        let calledIndex = dict[c]! // 인덱스를 뽑아주고
        dict[c] = dict[c]!-1; // 위치 변경
        dict[answer[calledIndex-1]] = dict[answer[calledIndex-1]]!+1 // 위치 변경
        //let tmp = answer[calledIndex-1]
        //answer[calledIndex-1] = answer[calledIndex]
        //answer[calledIndex] = tmp
        answer.swapAt(calledIndex-1, calledIndex)
    }
    return answer
}