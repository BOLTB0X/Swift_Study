import Foundation

func solution(_ arr:[Int]) -> [Int] {
    var arr: [Int] = arr
    
    // 빈 배열이 될 경우
    if arr.count == 1 {
        return [-1]
    } else { // 찾아야하는 경우
        let minElement: Int = arr.min()! // 배열의 최솟값 강제추출
        // 최솟값의 인덱스
        let minIndex: Int = arr.firstIndex(of: minElement)!
        arr.remove(at: minIndex) // 제거
    }
    
    // 배열 반환
    return arr
}