import Foundation

func solution(_ ingredient:[Int]) -> Int {
    // 빵 1 야채 2 고기 3 빵 1 이 순
    var answer: Int = 0
    var stack: [Int] = []
    
    for i in 0..<ingredient.count {
        // 스택에 3개 이상 쌓였고 현재 빵이면
        if ingredient[i] == 1 {
            // 포장할 수 있다면
            if stack.count >= 3 && stack[stack.count-1] == 3 &&
             stack[stack.count-2] == 2 && stack[stack.count-3] == 1 {
                // 스택 비우기
                for _ in 0..<3 {
                    stack.removeLast()
                }
                answer += 1
            } else { // 그 외
                stack.append(ingredient[i]) 
            }
        } else {
            stack.append(ingredient[i]) 
        }
    }
    
    return answer
}