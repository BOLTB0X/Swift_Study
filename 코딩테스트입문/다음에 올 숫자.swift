import Foundation

func solution(_ common:[Int]) -> Int {
    if common[0] + common[2] == common[1] * 2 {
        return common.last! + (common[1] - common[0])
    }
    return common.last! * (common[1] / common[0])
}