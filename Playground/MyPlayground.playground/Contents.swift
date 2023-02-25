import UIKit

var str = ["A 6", "B 12"]
var today = "2022.05.19"
var aaa = today.split(separator: ".")
var b = str.map{ $0.split(separator: " ") }


print(b)
for i in aaa.indices {
    print(aaa[i])
}

var val: Int64 = 118372
var arr = Int64(String(val).compactMap{String($0)}.sorted(by: >).joined(separator : ""))!
print(arr)
