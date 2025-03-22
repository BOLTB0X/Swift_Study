import Foundation

func solution(_ n:Int) -> Int {
    n % 2 == 1 ? getTotal(n) : getTotalPower(n)
}

func getTotal(_ n: Int) -> Int {
    (1...n).filter{$0%2==1}.reduce(0, +)
}

func getTotalPower(_ n: Int) -> Int {
    (1...n).filter{$0%2==0}.reduce(into: 0) {
        $0 += ($1*$1)
    }
}