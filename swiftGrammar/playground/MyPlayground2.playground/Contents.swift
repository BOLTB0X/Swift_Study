import UIKit

struct Human: Codable {
    var field: String
    var age: Int
}

// encoder선언
let encoder = JSONEncoder()

// human 구조체의 인스턴스 생성
let lkh = Human(field: "iOS", age: 30)

// encoder를 통해 Data형태로 변환
let jsonData = try? encoder.encode(lkh)

// Data형식의 jsonData를 String으로 편환
if let jsonData = jsonData, let jsonString = String(data: jsonData, encoding: .utf8) {
    print(jsonString)
}

let decoder = JSONDecoder()

// jsonString을 data타입으로 변형
var data = jsonString?.data(using: .utf8)

// data로부터 인스턴스를 만듬
if let data = data, let human = try? decoder.decode(Dinner.self, from: data) {
    print(human.age)
}
