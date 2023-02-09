import Foundation

func solution(_ box:[Int], _ n:Int) -> Int {
    // 고차함수 이용
    return box.map {$0 / n}.reduce(1, *)
}