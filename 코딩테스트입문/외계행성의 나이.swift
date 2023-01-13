import Foundation

func solution(_ age:Int) -> String {
    var answer = ""
    
    for str in String(age) {
        switch str {
            case "0":
                answer.append("a")
            case "1":
                answer.append("b")
            case "2":
                answer.append("c")
            case "3":
                answer.append("d")
            case "4":
                answer.append("e")
            case "5":
                answer.append("f")
            case "6":
                answer.append("g")
            case "7":
                answer.append("h")
            case "8":
                answer.append("i")
            default:
                answer.append("j")
        }
    }
    return answer
}