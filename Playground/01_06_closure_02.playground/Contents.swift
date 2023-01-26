import UIKit

// 기본 클로저 표현
func calculate(a: Int, b: Int, method: (Int, Int) -> Int) -> Int {
    return method(a, b)
}

var result: Int

// 후행 클로저
result = calculate(a: 10, b: 10) { (left: Int, right: Int) -> Int in
    return left + right
}

print(result)

// 반환타입 생략
result = calculate(a: 10, b: 10, method: { (left: Int, right: Int) in
    return left + right
})

print(result) // 20

// 후행클로저와 함께 사용할 수도 있습니다
result = calculate(a: 10, b: 10) { (left: Int, right: Int) in
    return left + right
}

print(result) // 20

// 단축 인자이름
result = calculate(a: 10, b: 10, method: {
    return $0 + $1
})

print(result) // 20

result = calculate(a: 10, b: 10) {
    return $0 + $1
}

print(result) // 20

// 암시적 반환 표현
result = calculate(a: 10, b: 10) {
    $0 + $1
}

print(result) // 20

// 간결하게 한 줄로 표현해 줄 수도 있습니다
result = calculate(a: 10, b: 10) { $0 + $1 }

print(result) // 20

// 축약 전과 후 비교
//축약 전
result = calculate(a: 10, b: 10, method: { (left: Int, right: Int) -> Int in
    return left + right
})

//축약 후
result = calculate(a: 10, b: 10) { $0 + $1 }

print(result) // 20
