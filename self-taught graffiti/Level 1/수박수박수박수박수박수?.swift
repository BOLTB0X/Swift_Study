func solution(_ n:Int) -> String {
    // 단순 풀이
    var answer: String = ""
    if n % 2 == 0 {
        var cnt = n / 2
        while cnt > 0 {
            answer += "수박"
            cnt -= 1
        }
    } else {
        var cnt = n / 2
        while cnt > 0 {
            answer += "수박"
            cnt -= 1
        }
        var cnt2 = n % 2 
            while cnt2 > 0 {
            answer += "수"
            cnt2 -= 1
        }
    }
    return answer
}