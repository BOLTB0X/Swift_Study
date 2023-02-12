import Foundation

func solution(_ t:String, _ p:String) -> Int {
    var answer:Int = 0
    var T = t.map{ String($0) } // 편의를 위해
    
    // t의 끝은 셀 필요가 없음  
    // 첫번 째 for문은 index 특성상 그냥 빼기고 < 처리하면
    // 한칸 부족
    for i in 0...t.count-p.count {
        var tmp:String = "" // 임시용
        for j in 0..<p.count { // 문자 조건만큼 부분문자열 생성
            tmp += T[j + i]
        }
        if Int(p)! >= Int(tmp)! { // 작거나 같다면
            answer += 1
        }
    }
    return answer 
}