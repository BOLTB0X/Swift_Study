import Foundation

func solution(_ sides:[Int]) -> Int {
    return (sides.max()! + sides.min()! - 1) - (sides.max()! - sides.min()!)
}