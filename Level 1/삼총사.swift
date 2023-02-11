import Foundation

//정답
var answer: Int = 0
// 방문리스트
var visited: [Bool] = Array(repeating: false, count: 14)

func solution(_ number:[Int]) -> Int {
    // 함수 호출
    DFS(arr: number, cur: 0, depth: 0)
    return answer
}

// dfs로 조합
func DFS(arr: [Int], cur: Int, depth: Int) {
    if depth == 3 {
        var tmpArr:[Int] = []
        
        // 방문처리된 index로 조합을 만듬
        for i in 0..<arr.count {
            if visited[i] {
                tmpArr.append(arr[i])
            }
        }
        // 삼총사 가능하면
        if tmpArr.reduce(0,+) == 0 {
            answer += 1
        }
        return
    }
    
    for i in cur..<arr.count {
        if !visited[i] {
            visited[i] = true
            DFS(arr: arr, cur: i+1, depth: depth+1)
            visited[i] = false // 다시 미방문 처리
        }
    }
}