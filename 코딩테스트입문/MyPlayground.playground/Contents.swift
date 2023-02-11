import UIKit

var s:String = "aukks"
var skip:String = "wbqd"


var index:Int = 5
var answer: String = ""

var box = [10, 8 ,6]

for b in box {
    print("\(b/3)")
}

print(box.map {$0 / 3}.reduce(1, *))

var s2: String = "1 2 Z 3"
var tot = 0
var _s = s2.split(separator: " ") // 편의를 위해 공백 제거
print(_s)

for i in _s.enumerated() {
    if i.1 == "Z" {
        print(_s[i.0 - 1])
        tot -= Int(_s[i.0-1])!
    } else {
        tot += Int(i.1)!
    }
//    print(i.0)
//    print(i.1)
}
print(tot)
