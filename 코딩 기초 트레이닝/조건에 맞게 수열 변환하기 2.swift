import Foundation

// 배열이 같은 지 
func check(_ arr1: [Int], _ arr2: [Int]) -> Bool {
    if arr2.count == 0 {
        return false
    }
    for i in 0..<arr1.count {
        if arr1[i] != arr2[i] {
            return false
        }
    }
    return true
}

// 조건에 맞게 수열 변환
func makeArray(_ arr: [Int]) -> [Int] {
    var ret:[Int] = []
    
    for i in 0..<arr.count {
        if arr[i] % 2 == 0 && arr[i] >= 50 {
            ret.append(arr[i]/2)
        } else if arr[i] % 2 == 1 && arr[i] < 50 {
            ret.append(arr[i]*2+1)
        } else {
            ret.append(arr[i])
        }
    }
    
    return ret
}

func solution(_ arr:[Int]) -> Int {
    var answer:Int = 0
    var arr = arr
    var backupArr:[Int] = []
    
    while true {
        if check(arr, backupArr) {
            break
        }
        
        backupArr = arr // 백업 arr(x)
        arr = makeArray(arr) // arr(x+1)
        answer += 1
    }
    
    return answer - 1 // x를 반환하므로
}