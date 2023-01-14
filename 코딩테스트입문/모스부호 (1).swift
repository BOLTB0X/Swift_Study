import Foundation

func solution(_ letter:String) -> String {
    var answer = ""
    // 딕셔너리 이용
    let morse = [
    ".-":"a", "-...":"b", "-.-.":"c", "-..":"d", ".":"e", "..-.":"f",
    "--.":"g","....":"h","..":"i",".---":"j","-.-":"k",".-..":"l",
    "--":"m","-.":"n","---":"o",".--.":"p","--.-":"q",".-.":"r",
    "...":"s","-":"t","..-":"u","...-":"v",".--":"w","-..-":"x",
    "-.--":"y","--..":"z"
    ]

    var tmp = "" // 임시용
    for l in letter {
        if l == " " {
            answer.append(morse[tmp]!)
            tmp = ""
        } else {
            tmp.append(l)
        }
    }
    
    answer.append(morse[tmp]!)
    return answer
}