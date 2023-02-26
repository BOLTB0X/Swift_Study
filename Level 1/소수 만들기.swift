import Foundation

// 소수 판별
func isPrime(_ number: Int) -> Bool {
    if number == 0 || number == 1 {
        return false
    } else {
        for i in 2..<number {
            if number % i == 0 {
                return false
            }
        }
    }
    
    return true
}

func solution(_ nums:[Int]) -> Int {
    var answer:Int = 0
    
    // 완전탐색
    for i in 0...nums.count-3 {
        for j in i+1...nums.count-2 {
            for k in j+1...nums.count-1{
                // 소수인지 체크
                if isPrime(nums[i]+nums[j]+nums[k]) {
                    answer += 1
                }
            }
        }
        
    } 
    return answer
}