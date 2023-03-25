import UIKit

struct Human: Codable {
    var field: String
    var age: Int
}

let lkh = Human(field: "dev", age: 30)

print(lkh)

let encoder = JSONEncoder()

// human 구조체의 인스턴스 생성
let lkh = Human(field: "iOS", age: 30)

// encoder를 통해 Data형태로 변환
let jsonData = try? encoder.encode(lkh)

// Data형식의 jsonData를 String으로 편환
if let jsonData = jsonData, let jsonString = String(data: jsonData, encoding: .utf8) {
    print(jsonString)
}

