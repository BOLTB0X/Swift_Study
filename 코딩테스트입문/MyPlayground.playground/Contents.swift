import UIKit

var s:String = "aukks"
var skip:String = "wbqd"


var index:Int = 5
var answer: String = ""

var age:Int = 23
String(age).map {
    String(UnicodeScalar(UInt8(Int(String($0))! + 97)))
}.joined(separator: "")
