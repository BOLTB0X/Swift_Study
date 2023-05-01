import Foundation

func solution(_ n:Int) -> [Int] {
    var answer:[Int] = [n]
    var number = n
    
    while number != 1 {
        if number % 2 == 0 {
            number /= 2
            answer.append(number)
        } else {
            number = 3*number+1
            answer.append(number)
        }
    } 
    
    return answer
}