import Foundation

// 최대공약수 = 재귀
func gcd(_ a:Int, _ b:Int) -> Int {
    if a % b == 0 {
        return b
    }
    return gcd(b, a%b)
}

func solution(_ numer1:Int, _ denom1:Int, _ numer2:Int, _ denom2:Int) -> [Int] {
    // 분수 덧샘
    // a/b + c/d = (ad+bc)/bd
    var maxNumer = numer1 * denom2 + numer2 * denom1
    var maxDenom = denom1 * denom2
    
    // 반환
    return [maxNumer / gcd(maxNumer, maxDenom), maxDenom / gcd(maxNumer, maxDenom)]
}