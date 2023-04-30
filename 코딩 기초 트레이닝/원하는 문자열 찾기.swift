import Foundation

func solution(_ myString:String, _ pat:String) -> Int {
    // 알파벳을 구분하지 않는다 하니
    let myString = myString.lowercased()
    //print(myString)
    let pat = pat.lowercased()
    //print(pat)
    
    return myString.contains(pat) ? 1 : 0
}