import Foundation

func solution(_ arr:[[Int]]) -> [[Int]] {
    var arr:[[Int]] = arr
    if arr.count == arr[0].count {
        return arr
    } else {
        // arr의 행의 수가 더 많다면 
        if arr.count > arr[0].count {
            for i in 0..<arr.count {
                // 열의 수가 행의 수와 같아지도록 각 행의 끝에 0을 추가
                for j in 0..<(arr.count - arr[i].count) {
                    arr[i].append(0)
                }
            }
        } else {
            for i in 0..<(arr[0].count - arr.count) {
                // 열의 수가 더 많다면 행의 수가 열의 수와 같아지도록
                var tmp:[Int] = []
                for j in 0..<arr[0].count {
                    tmp.append(0)
                }
                
                arr.append(tmp)
            }
        }
    }
    
    return arr
}