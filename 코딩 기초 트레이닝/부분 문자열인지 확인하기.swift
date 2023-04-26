import Foundation

func solution(_ my_string:String, _ target:String) -> Int {
    return my_string.contains(target) == true ? 1 : 0
}