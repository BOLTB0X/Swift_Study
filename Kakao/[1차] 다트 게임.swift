func solution(_ dartResult:String) -> Int {
    var stack:[Int] = []
    var Result = dartResult.map{String($0)} // 편의용
    
    // 정수를 임시로 담을 프로퍼티
    var tmp:String = ""
    
    // 이제 단순 풀이
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
            if stack.count <= 1 {
                stack = stack.map{$0 * 2}
            } else {
                stack[stack.count-1] = stack[stack.count-1] * 2
                stack[stack.count-2] = stack[stack.count-2] * 2
            }
        }
        else if Result[i] == "#" {
            if "#" == Result[i-1] && i != 0 {
                stack[stack.count-1] = stack[stack.count-1] * 2
            } else {
                stack[stack.count-1] = stack[stack.count-1] * -1
            }
        }
    }
    
    return stack.reduce(0,+)
}