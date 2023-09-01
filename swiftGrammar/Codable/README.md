# Codable

> A type that can convert itself into and out of an external representation.
> <br/>

자기 자신을 변환하거나 외부 표현으로 변할 수 있는 타입 -> 인코딩 및 디코딩을 위한 키로 사용할 수 있는 타입
<br/>

```swift
struct Human: Codable {
	var field: String
	var age: Int
}
```

## Encodable

> A type that can encode itself to an external representation
> <br/>

자기 자신을 외부 표현(such as JSON)으로 변환
<br/>

```swift
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
```

## Decodable

> A type that can decode itstelf from an external representation
> <br/>

외부표현(such as JSON)을 자기 자신으로 변환
<br/>

```swift
// decoder 생성
let decoder = JSONDecoder()

// jsonString을 data타입으로 변형
var data = jsonString?.data(using: .utf8)

// data로부터 인스턴스를 만듬
if let data = data, let human = try? decoder.decode(Dinner.self, from: data) {
    print(human.age)
}
```

---

## 자료출처

[애플 개발자 공식문서 -codable-](https://developer.apple.com/documentation/swift/codable)
<br/>

[상어의 개발블로그](https://shark-sea.kr/entry/Swift-Codable-알아보기)
<br/>
