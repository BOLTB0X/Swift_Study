import UIKit
import Foundation

var arr = [1,1,3,3,0,1,1]

func solution(_ arr: [Int]) -> [Int] {
    var answer:[Int] = [] // 정답
    var st:[Int] = [] // 스택

    // 단순풀이
    for i in 0..<arr.count {
        if st.count == 0 {
            st.append(arr[i])
            answer.append(arr[i])
        } else {
            // 같은 숫자를 보면
            if st.last == arr[i] {
                continue
            }
            // 다른 숫자이니 넣어줌
            st.append(arr[i])
            answer.append(arr[i])
        }
    }
    return answer
}

print(solution(arr))
