//
//  main.swift
//  BOJ16926Swift
//
//  Created by KyungHeon Lee on 2023/04/04.
//

import Foundation

// 시간초과
// MARK: 입력
let inputs = readLine()!.split(separator: " ").map { Int($0)! }
let N = inputs[0]
let M = inputs[1]
let R = inputs[2]

var board:[[Int]] = []

for _ in 0..<N {
    board.append(readLine()!.split(separator: " ").map{ Int($0)!})
}

// MARK: printArray
func printArray() {
    board.forEach{
        print($0.map{String($0)}.joined(separator: " "))
    }
}

// MARK: rotate
// 제일 먼저 돌려야할 사각형 갯수를 알야야함
// min(n,m) / 2이 총 보드에 돌리는 횟수

// 돌려야  하는 사각형 각각의 최대 길이는
// nMax = n - ( min(n, m) / 2 ) - 1 , mMax = m - ( min(n, m) / 2 ) - 1
func rotateArray() {
    let totalCount = min(N, M) / 2
    
    for cnt in 0..<totalCount {
        let nMax = N-cnt-1
        let mMax = M-cnt-1
        
        let tmp = board[cnt][cnt]
        
        // MARK: 왼 <- 오
        for i in cnt..<mMax {
            board[cnt][i] = board[cnt][i+1]
        }
        
        // MARK: 아래 -> 위
        for i in cnt..<nMax {
            board[i][mMax] = board[i+1][mMax]
        }
        
        // MARK: 오 -> 왼
        for i in (cnt+1...mMax).reversed() {
            board[nMax][i] = board[nMax][i-1]
        }
        
        // MARK: 위 -> 아래
        for i in (cnt+1...nMax).reversed() {
            board[i][cnt] = board[i-1][cnt]
        }
        
        board[cnt+1][cnt] = tmp
    }
}

func solution() {
    for i in 0..<R {
        rotateArray()
//        printArray()
//        print("===========구분=============")
    }
}

solution()
printArray()
