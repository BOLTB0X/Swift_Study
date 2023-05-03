import Foundation

let inp = readLine()!.components(separatedBy: [" "]).map { $0 }
let (s1, a) = (inp[0], Int(inp[1])!)

var str:String = ""

for _ in 0..<a {
    str += s1
}

print(str)
// print(String(repeating: s1, count: a))
