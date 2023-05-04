import Foundation

func solution(_ ineq:String, _ eq:String, _ n:Int, _ m:Int) -> Int {
    if ineq == ">" {
        if eq == "=" {
            return n >= m ? 1 : 0;
        } else {
            return n > m ? 1 : 0;
        }
    } else {
        if eq == "=" {
            return n <= m ? 1 : 0;
        } else {
            return n < m ? 1 : 0;
        }
    }
    return 0
}