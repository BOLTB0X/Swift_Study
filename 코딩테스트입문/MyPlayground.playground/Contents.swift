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
