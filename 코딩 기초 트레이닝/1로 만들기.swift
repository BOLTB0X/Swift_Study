import Foundation

func doSomething(_ n:Int) -> Int {
    var cnt = 0
    var n = n
    
    while n > 1 {
        if n % 2 == 0 {
            n /= 2
        } else {
            n -= 1
            n /= 2
        }
        cnt += 1
    }
    return cnt
}

func solution(_ num_list:[Int]) -> Int {
    var answer = 0
    
    for num in num_list {
        answer += doSomething(num)
    }
    return answer
}