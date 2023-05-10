import Foundation

func solution(_ my_string:String, _ s:Int, _ e:Int) -> String {
    var arr = my_string.map{String($0)}
    return my_string.replacingOccurrences(of: Array(arr[s...e]).joined()
                                       ,with:Array(arr[s...e]).reversed().joined())
}