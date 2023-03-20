import Foundation

let str:String = "swift"
for c in str {
    print("element : \(c), type: \(type(of: c))")
    //    element : s, type: Character
    //    element : w, type: Character
    //    element : i, type: Character
    //    element : f, type: Character
    //    element : t, type: Character
    
}

let str2 = "스위프트"

print(str+str2) // swift스위프트

let a = "1"
let b = "2"
let c = "a"
let d = "b"

print(a > b) // false
print(c < d) // true

print(str[str.startIndex]) // s
print(str[str.index(before: str.endIndex)]) // t
print(str[str.index(after: str.startIndex)]) // w
print(str[str.index(str.startIndex, offsetBy: 2)]) // i
print(str[str.index(str.endIndex, offsetBy: -2)]) // f

let tmpstr = "hello swift"
if let index = tmpstr.firstIndex(of: "o") {
    print(index) // 4
}

if let index = tmpstr.lastIndex(of: "o") {
    print(index) // 7
}

let tmp = "Apple"
print(tmp.contains("A")) // true
print(tmp.contains("a")) // false
