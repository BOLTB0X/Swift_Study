import Foundation

func solution(_ my_string:String) -> Int {
    let numbersArr : [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] // 확인용 문자형 배열
    var tmpStr : String = "" // 두자리수 방지용 문자열
    var tot: Int = 0 // 총합
    
    for mystr in my_string {
        // 현재가 숫자이면
        if numbersArr.contains(mystr) {
            tmpStr += String(mystr)
        } else { // 문자이면 더해줌
            if tmpStr.count > 0 { // 여러번 문자가 나오는 것을 방지
                tot += Int(tmpStr)!
                tmpStr = "" // 초기화
            }
        }
    }
    
    if tmpStr.count > 0 { // 마지막 확인
        tot += Int(tmpStr)!
    }
    
    return tot
}