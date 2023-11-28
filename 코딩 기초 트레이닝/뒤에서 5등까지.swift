// https://school.programmers.co.kr/learn/courses/30/lessons/181853
import Foundation

func solution(_ num_list:[Int]) -> [Int] {
    Array(num_list.sorted()[0..<5])
}