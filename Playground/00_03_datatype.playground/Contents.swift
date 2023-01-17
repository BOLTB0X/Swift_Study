import UIKit

var someBool: Bool = true
someBool = false
// someBool = 0 // 컴파일 오류발생
// someBool = 1 // 컴파일 오류발생

// Float
var someFloat: Float = 3.14
someFloat = 3

// Double
var someDouble: Double = 3.14
// someDouble = 3
// someDouble = someFloat // 컴파일 오류발생

// Character
var someCharacter: Character = "🇰🇷"
someCharacter = "😄"
someCharacter = "가"
someCharacter = "A"
// someCharacter = "하하하" // 컴파일 오류발생
print(someCharacter)

// String
var someString: String = "하하하 😄 "
someString = someString + "웃으면 복이와요"
//print(someString)
// someString = someCharacter // 컴파일 오류발생

// 생각해보기
let integer = 100
let floatingPoint = 12.34
let apple = "A"

print(type(of:integer))
print(type(of:floatingPoint))
print(type(of:apple))
