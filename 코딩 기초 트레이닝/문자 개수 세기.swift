import Foundation

func solution(_ my_string:String) -> [Int] {
    var counts = Array(repeating: 0, count: 52)
    
    // asciiValue 이용
    for ch in my_string {
        if ch.isUppercase {
            let index = Int(ch.asciiValue! - Character("A").asciiValue!)
            counts[index] += 1
        } else if ch.isLowercase {
            let index = Int(ch.asciiValue! - Character("a").asciiValue!) + 26
            counts[index] += 1
        }
    }
    
    return counts
}