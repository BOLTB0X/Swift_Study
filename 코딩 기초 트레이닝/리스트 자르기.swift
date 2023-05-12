import Foundation

func solution(_ n:Int, _ slicer:[Int], _ num_list:[Int]) -> [Int] {
    var answer:[Int] = []
    
    if n == 1 {
        return Array(num_list[0...slicer[1]])
    } else if n == 2 {
        return Array(num_list[slicer[0]..<num_list.count])
    } else if n == 3 {
        return Array(num_list[slicer[0]...slicer[1]])
    } else {
        for i in stride(from: slicer[0], through: slicer[1], by: slicer[2]) {
            answer.append(num_list[i])
        }
    }
    return answer
}