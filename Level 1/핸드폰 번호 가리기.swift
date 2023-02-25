func solution(_ phone_number:String) -> String {
    // 단순 풀이
    // prefix(_:) 앞에서 부터
    // suffix(_:) 뒤에서 부터
    return  String("\(String(repeating: "*", count: phone_number.count - 4))\(phone_number.suffix(4))")
}