import Foundation

func solution(_ quiz:[String]) -> [String] {
    var answer = [String]()
    
    for q in quiz {
        var arr = q.split(separator: " ") // 공백 기준으로 분리
        var tot = Int(arr[0]) // 합 변수
        
        // 이제 반복문으로 o,x 체크
        for idx in arr.enumerated() {
            if idx.element == "-" {
                tot! -= Int(arr[idx.offset + 1])!
                
                // 같다면
                if Int(arr[idx.offset + 3]) == tot {
                    answer.append("O")
                } else {
                    answer.append("X")
                }
            }
            
            else if idx.element == "+" {
                tot! += Int(arr[idx.offset + 1])!
                
                // 같다면
                if Int(arr[idx.offset + 3]) == tot {
                    answer.append("O")
                } else {
                    answer.append("X")
                }
            }
        }
    }
    return answer
}