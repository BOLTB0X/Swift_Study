import Foundation

func solution(_ today:String, _ terms:[String], _ privacies:[String]) -> [Int] {
    var answer: [Int] = []
    var terms = transTermsDict(terms) // 편의용 딕셔너리로 변환
    var privacies = transPrivaciesDict(privacies) // 만료정보 분리
    
    // today를 편의를 위해 년,월,일로 나눔
    var today = today.split(separator: ".")
    var year = Int(today[0])! // nil인 경우가 있으므로
    var month = Int(today[1])!
    var day = Int(today[2])!
    
    for (key, value) in privacies {
        // 비교 개인정보일 .기준으로 분리
        // 저 오늘 처럼분리 
        var tmp = key.split(separator: ".")
        var sampleYear = Int(tmp[0])!
        var sampleMonth = Int(tmp[1])!
        var sampleDay = Int(tmp[2])!
        var sampleIdx = Int(tmp[3])! // 순번
        
        // value가 A,B,C 그러므로 terms을 이용
        var deadLineMonth = terms[value]!
        
        sampleMonth += deadLineMonth
        // 해가 변한 경우
        if sampleMonth > 12 {
            sampleYear += sampleMonth/12
            sampleMonth -= (sampleMonth/12) * 12
            
            // 0인 경우
            if sampleMonth == 0 {
                sampleYear -= 1
                sampleMonth = 12 // 0이면 12월임
            }
        }
        
        // 만약 1일이면 28일로 계산해야하므로
        if sampleDay == 1 {
            sampleMonth -= 1
            if sampleMonth == 0 {
                sampleMonth = 12
            }
            sampleDay = 28
        } else { // 그 외면 그냥 1빼줌
            sampleDay -= 1
        }
        
        // 이미 지난 경우
        if year > sampleYear {
            answer.append(sampleIdx)
        } else if year == sampleYear && 
         month > sampleMonth{ // 같은 해이면 달을 확인
            answer.append(sampleIdx)
        } else if year == sampleYear && 
         month == sampleMonth && 
        day > sampleDay{ // 같은 달이면 일 확인
            answer.append(sampleIdx)
        }
    }
    
    return answer.sorted() // 오름차순 정렬
}

// 딕셔너리 변환 (Term용)
func transTermsDict( _ terms:[String]) -> [String : Int] {
    var ret = [String: Int]() // 딕셔너라
    
    for arr in terms {
        var tmp = arr.split(separator: " ")
        // key가 알파벳, value가 순번
        ret[String(tmp[0])] = Int(tmp[1]) // 변환
    }
    
    return ret
}

// 딕셔너리 변환 (privacy용)
func transPrivaciesDict(_ privacy: [String]) -> [String: String]{
    var ret = [String: String]() // 반환용
    var idx = 0 // 순번
    
    for pri in privacy {
        // 공백 기준으로
        var tmp = pri.split(separator: " ")
        idx += 1 // 알파벳순이 아닌 순번
       
        // 순번을 뒤에 같이 붙여줌
        ret[String(tmp[0])+"."+String(idx)] = String(tmp[1])
    }
    
    return ret
}