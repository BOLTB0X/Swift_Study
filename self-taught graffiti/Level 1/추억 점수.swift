import Foundation

func solution(_ name:[String], _ yearning:[Int], _ photo:[[String]]) -> [Int] {
    var answer:[Int] = []
    // 진 속에 나오는 인물의 그리움 점수를 모두 합산한 값이 해당 사진의 추억 점수가 됩니다
    // 그냥 단순 idx맞추어 점수 계산하면 됌
    // -> 딕셔너리 이용
    var dict:[String:Int] = [:]
    
    // name에는 중복된 값이 들어가지 않습니다.
    var idx:Int = 0
    for n in name {
        dict[n] = yearning[idx]
        idx += 1
    }
    
    // 이제 한 행씩 점수 계산해서 넣어줌
    for i in 0..<photo.count {
        var score:Int = 0
        for ph in photo[i] {
            // 점수가 있는 경우
            if let _ = dict[ph] {
                score += dict[ph]!
            } else { // 없는 경우
                continue
            }
        }
        answer.append(score)
    }
    
    return answer
}