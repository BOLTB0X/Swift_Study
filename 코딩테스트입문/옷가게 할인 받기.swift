import Foundation

func solution(_ price:Int) -> Int {
    var answer = 0
    
    switch price {
    case 500000...:
        answer = Int(Double(price) * 0.8)
    
    case 300000..<500000:
        answer = Int(Double(price) * 0.9)
    
    case 100000..<300000:
        answer = Int(Double(price) * 0.95)
        
    default:
        answer = price
    }
    return answer
}