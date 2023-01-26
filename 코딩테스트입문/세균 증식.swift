import Foundation

func solution(_ n:Int, _ t:Int) -> Int {
    // pow 이용
    // Int를 반환하려면 float형으로 호출해야함
    n * Int(pow(2.0, Float(t)))
}