import Foundation

func solution(_ spell:[String], _ dic:[String]) -> Int {
    var answer = 2 // 기본으로 2로 설정
    
    // 체크할 단어 순회
    for d in dic {
        // 알파벳을 하나씩 확인
        for s in spell {
            // 알파벳이 있다면
            if d.contains(s) {
                answer = 1
            } else { // 없다면 
                answer = 2 // 2로 수정
                break // 이 단어를 볼 필요가 없으므로
            }
        }
        // 검사를 다 맞친 후 다 들어가 있다면
        if answer == 1 {
            break
        }
    }
    return answer
}