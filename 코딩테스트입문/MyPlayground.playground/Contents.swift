import UIKit

var s:String = "aukks"
var skip:String = "wbqd"


var index:Int = 5
var answer: String = ""

for _s in s {
    // 현재 _s의 아스키코드값으로 변환
    var asci = Int(UnicodeScalar(String(_s))!.value)
    // 5번 뒤로 밀기
    for _ in 1...index {
        // repeat while 반복문
        repeat {
            asci += 1
            if asci > 122 { // z를 넘어가면
                asci = 97 // a로 초기화
            }
            // skip에 알파벳이 있다면 반복
        } while(skip.contains(String(UnicodeScalar(asci)!)))
    }
    answer += String(UnicodeScalar(asci)!)
}
print(answer)
