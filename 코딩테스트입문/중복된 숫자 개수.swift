import Foundation

func solution(_ array:[Int], _ n:Int) -> Int {
    array.filter { $0 == n }.count
}