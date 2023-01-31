import Foundation

func solution(_ before:String, _ after:String) -> Int {
    // 순열처럼 자리를 바꾸어 같다면
    // 알파벳 정렬 순서가 같아야하므로
    Array(before).sorted() == Array(after).sorted() ? 1 : 0
}