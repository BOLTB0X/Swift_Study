import Foundation

let stringArr1 = ["sam", "coco", "Thierry", "Sherry", "John"]

for item in stringArr1 {
    if item.hasPrefix("s") {
        print("통과 O : \(item)")
    } else {
        print("통과 X")
    }
    
//    통과 O : sam
//    통과 X
//    통과 X
//    통과 X
//    통과 X
}

let stringArr2 = ["sam", "coco", "Thierry", "Sherry", "John"]

for item in stringArr2 {
    if item.hasSuffix("y") {
        print("통과 O : \(item)")
    } else {
        print("통과 X")
    }

//    통과 X
//    통과 X
//    통과 O : Thierry
//    통과 O : Sherry
//    통과 X
}


let stringArr3 = ["sam", "coco", "Thierry", "Sherry", "John"]

print(stringArr3.joined(separator: ""))
// samcocoThierrySherryJohn
