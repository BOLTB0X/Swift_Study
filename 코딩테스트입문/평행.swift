import Foundation

func solution(_ dots:[[Int]]) -> Int {
    var leanCandi : [Double] = []
    var flag = 0
    
    for i in 0..<4 {
        for j in i+1..<4 { // i 보다 한칸 옆으로
            // 현재 좌표들로 기울기 y/x
            var curLean = Double(dots[i][1] - dots[j][1]) / Double(dots[i][0] - dots[j][0])
            
            // 현재 기울기와 같은 기울기가 배열안에 있으면 평행이므로
            if leanCandi.contains(curLean) {
                return 1
            }
            // 후보안에 넣기
            leanCandi.append(curLean)
        }
    }
    return 0
}