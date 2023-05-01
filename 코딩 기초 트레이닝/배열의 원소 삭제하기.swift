import Foundation

func solution(_ arr:[Int], _ delete_list:[Int]) -> [Int] {
    var arr = arr
    
    for ele in delete_list {
        // 원소가 있으면
        if arr.contains(ele) == true {
            if let idx = arr.firstIndex(of: ele) {
                arr.remove(at: idx)
            }
        }
    }
    return arr
    // return arr.filter { !delete_list.contains($0) }
}