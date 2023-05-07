import Foundation

func solution(_ arr:[Int]) -> [Int] {
    var stk:[Int] = []
    var idx:Int = 0
    
    // 변수 i를 만들어 초기값을 0으로 설정한 후 i가 arr의 길이보다 작으면 다음 작업을 반복
    while idx < arr.count {
        if stk.isEmpty { // 만약 stk가 빈 배열이라면
            stk.append(arr[idx])
            idx += 1
        } else { // stk에 원소가 있다면
            if stk.last! < arr[idx] { // stk의 마지막 원소가 arr[i]보다 작으면
                stk.append(arr[idx]) // arr[i]를 stk의 뒤에 추가
                idx += 1
            } else { // stk의 마지막 원소가 arr[i]보다 크거나 같으면
                stk.removeLast() // stk의 마지막 원소를 stk에서 제거
            }
        }
    }
    return stk
}