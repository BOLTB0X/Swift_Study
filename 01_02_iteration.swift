var arr : [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// 기본 반목문
for item in arr {
    print("item : \(item)")
}

// 반복문 안에 조건 추가
for item in arr where item > 5 {
    print("5보다 큰 수 : \(item)")
}

for item in arr where item % 2 == 0 {
    print("짝수 : \(item)")
}