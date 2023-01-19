import Foundation

func solution(_ sides:[Int]) -> Int {
    let side = sides.sorted() // 오름차순 정렬
    
    return side[2] < side[0] + side[1] ? 1 : 2 // 삼항연산자
}