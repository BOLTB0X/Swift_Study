import Foundation

func solution(_ letter:String) -> String {
    let morse = [
    ".-":"a", "-...":"b", "-.-.":"c", "-..":"d", ".":"e", "..-.":"f",
    "--.":"g","....":"h","..":"i",".---":"j","-.-":"k",".-..":"l",
    "--":"m","-.":"n","---":"o",".--.":"p","--.-":"q",".-.":"r",
    "...":"s","-":"t","..-":"u","...-":"v",".--":"w","-..-":"x",
    "-.--":"y","--..":"z"
    ]

    // components로 공백을 지워줌
    // map을 이용하여 해당 value를 구해주
    return letter.components(separatedBy: " ").map{ morse[$0]! }.joined(separator: "")
}