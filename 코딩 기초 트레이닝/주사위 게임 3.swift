import Foundation

func solution(_ a:Int, _ b:Int, _ c:Int, _ d:Int) -> Int {
    var answer:Int = 0
    
    if a == b && b == c && c == d {
        answer = 1111 * a
    } else if a == b && b == c {
        answer = (10*a+d) * (10*a+d)
    } else if a == d && d == c {
        answer = (10*a+b) * (10*a+b)
    } else if b == d && d == c {
        answer = (10*d+a) * (10*d+a)
    } else if a == d && d == b {
        answer = (10*a+c) * (10*a+c)
    } else if a == b && c == d {
        answer = (a + c) * abs(a - c)
    } else if a == c && b == d {
        answer = (a + b) * abs(a - b)
    } else if a == d && c == b {
        answer = (a + c) * abs(a - c)
    } else if a == b && a != c && a != d && c != d {
        answer = c*d
    } else if a == c && a != b && a != d && b != d {
        answer = b*d
    } else if a == d && a != b && a != c && b != c {
        answer = b*c
    } else if b == c && b != a && b != d && a != d {
        answer = a*d
    } else if b == d && b != a && b != c && a != c {
        answer = a*c
    } else if c == d && c != b && c != a && a != b {
        answer = a*b
    } else {
        var minValue:Int = 6;
        if minValue >= a {
            minValue = a
        }
        if minValue >= b {
            minValue = b
        }
        
        if minValue >= c { 
            minValue = c
        }
        
        if minValue >= d { 
            minValue = d
        }
        answer = minValue
    }
    return answer
}