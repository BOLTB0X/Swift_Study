import Foundation

let n = readLine()!.components(separatedBy: [" "]).map { Int($0)! }

let len = n.first!

for i in (1...len) {
    print(String(repeating: "*", count: i))
}