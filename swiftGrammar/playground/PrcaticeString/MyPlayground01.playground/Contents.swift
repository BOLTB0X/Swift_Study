import UIKit

let stringArr = ["sam", "coco", "Thierry", "Sherry", "John"]

for item in stringArr {
    if item.hasPrefix("o") {
        print("통과 O : \(item)")
    } else {
        print("통과 X")
    }
}
