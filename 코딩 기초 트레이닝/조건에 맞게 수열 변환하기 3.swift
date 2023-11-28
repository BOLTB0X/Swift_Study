// https://school.programmers.co.kr/learn/courses/30/lessons/181835
import Foundation

func solution(_ arr:[Int], _ k:Int) -> [Int] {
    arr.map { k % 2 == 1 ? $0*k : $0+k }
}