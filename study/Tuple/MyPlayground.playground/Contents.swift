import UIKit

// 단순 튜플
let point: (Int, Int) = (3, 5)
print(point.0) // 3
print(point.1) // 5

// 라벨 있는 튜플
let labeledPoint: (x: Int, y: Int) = (x: 3, y: 5)
print(labeledPoint.x) // 3
print(labeledPoint.y) // 5

// 서로 다른 타입도 가능
let somthing: (String, Int, Bool) = ("Jordan", 275, true)
print(somthing.0) // "Shose"
print(somthing.1) // 275
print(somthing.2) // true

func minMax(of numbers: [Int]) -> (min: Int, max: Int)? {
    guard let first = numbers.first else { return nil }
    var minValue = first, maxValue = first
    for n in numbers {
        if n < minValue { minValue = n }
        if n > maxValue { maxValue = n }
    }
    return (min: minValue, max: maxValue)
}

if let result = minMax(of: [3, 7, 1, 9]) {
    print("min = \(result.min), max = \(result.max)")
}
// min = 1, max = 9

let (shose, size, soldout) = somthing
print(shose) // Jordan
print(size)  //275

let (x, _, z) = (1, 2, 3)
print(x, z) // 1 3

let pos = (3, 0)

switch pos {
    case (0, 0):
        print("원점")
    case (let x, 0):
        print("x 축 위에 \(x)")
    case (0, let y):
        print("y 축 위에 \(y)")
    case (let x, let y) where x == y:
        print("둘다 같은 값 \(x) == \(y)")
    default:
        print("어딘가에 있겠지")
}

let dict = ["one": 1, "two": 2, "three": 3, "four": 4, "five": 5, "six": 6]

for (k, v) in dict {
    print(k, v)
}

//five 5
//two 2
//three 3
//six 6
//four 4
//one 1

let fruits = ["apple", "banana", "cherry"]

for (index, fruit) in fruits.enumerated() {
    print("\(index): \(fruit)")
}
// 0: apple
// 1: banana
// 2: cherry

let numbers = [1, 2, 3, 4]

let squaredWithIndex = numbers.enumerated().map { (index, value) in
    (index, value * value)
}

print(squaredWithIndex)


let a = (2, "apple")
let b = (2, "banana")

print(a < b) // true

let httpResponse = (statusCode: 404, message: "Not Found")
print(httpResponse.statusCode) // 404
print(httpResponse.message)    // Not Found

