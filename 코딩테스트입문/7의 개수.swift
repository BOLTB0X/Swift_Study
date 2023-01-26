import Foundation

func solution(_ array:[Int]) -> Int {
    // 무식한 풀이
    // var answer = 0
    // for i in array.enumerated() {
    //     for st in String(i.element) {
    //         if st == "7" {
    //             answer += 1
    //         }
    //     }
    // }
    // return answer

    // map 이용
    array.map{String($0)}.joined().filter{$0 == "7"}.count
}