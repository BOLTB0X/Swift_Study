import Foundation

func solution(_ my_string:String, _ num1:Int, _ num2:Int) -> String {
    // swap을 이용
    // swift는 문자열 swap가 안되므로 배열로 타입 변환
    var Arr = ArraySlice(my_string)

    Arr.swapAt(num1, num2) // 스와핑

    return Arr.map {String($0)}.joined() // 다시 배열을 문자열로 변환
}