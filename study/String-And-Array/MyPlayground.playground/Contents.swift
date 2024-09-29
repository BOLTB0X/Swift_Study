import Foundation

//let str1 = "Hi"
//let str2 = str1.map { $0 } // 배열로 변경
//
//print(str2.joined()) // error

let str1 = "Hi"
let str2 = str1.map { String($0) }

print(str2.joined())
// Hi

let str3 = "Bye"
let str4 = Array(str3)
print(String(str4))
// Bye
