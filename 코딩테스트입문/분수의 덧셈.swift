import Foundation

// 최대공약수
func gcd(_ a:Int, _ b:Int) -> Int {
    if a % b == 0 {
        return b
    }
    
    return gcd(b, a%b)
}

func solution(_ numer1:Int, _ denom1:Int, _ numer2:Int, _ denom2:Int) -> [Int] {
    var maxNumer = numer1 * denom2 + numer2 * denom1 // 분자
    var maxDenom = denom1 * denom2 // 분모
    
    return [maxNumer / gcd(maxDenom, maxNumer), maxDenom / gcd(maxDenom, maxNumer)]
}