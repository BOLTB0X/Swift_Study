import UIKit

var dartResult = "1S2D*3T"
var stack:[Int] = []
var Result = dartResult.map{String($0)}

var tmp:String = ""

for i in Result.indices {
    // 정수인 경우
    if Result[i] >= "0" && Result[i] <= "9" {
        tmp.append(Result[i])
    }
    else if Result[i] == "S" {
        stack.append(Int(tmp)!)
        tmp = "" //초기화
    }
    else if Result[i] == "D" {
        stack.append(Int(tmp)!*Int(tmp)!)
        tmp = "" //초기화
    }
    else if Result[i] == "T" {
        stack.append(Int(tmp)!*Int(tmp)!*Int(tmp)!)
        tmp = "" //초기화
    }
    else if Result[i] == "*" {
        stack = stack.map{$0 * 2}
    }
    else if Result[i] == "#" {
        if "#" == Result[i-1] && i != 0 {
            stack[stack.count-1] = stack[stack.count-1] * 2
        } else {
            stack[stack.count-1] = stack[stack.count-1] * -1
        }
    }
    print(stack)
}
