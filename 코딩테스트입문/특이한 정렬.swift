import Foundation

func solution(_ numlist:[Int], _ n:Int) -> [Int] {
    return numlist.sorted(by: { a, b in
        var num1 = abs(a - n)
        var num2 = abs(b - n)
        
        // 거리가 같다면
        if num1 == num2 {
            return a > b // 큰 것을 먼저
        } else { // 그 외인 경우
            return num1 < num2 // 작은 것이 먼저
        }
    } )
}