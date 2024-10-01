import Foundation

let line = "BLANCHE:   I don't want realism. I want magic!"

print(line.split(separator: " "))
// ["BLANCHE:", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]

print(line.split(separator: " ", maxSplits: 1))
// ["BLANCHE:", "  I don\'t want realism. I want magic!"]

print(line.split(separator: " ", omittingEmptySubsequences: false))
// ["BLANCHE:", "", "", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]

let str = "Hello,World,,Swift"
let result = str.components(separatedBy: ",")

print(result)
// ["Hello", "World", "", "Swift"]
