import UIKit

var answer = 0

var coke = 20

while coke > 2 {
    answer += ((coke / 2) * 1)
    coke /= 2
    print(answer)
    if coke % 2 != 0{
        answer += 1
    }
}

