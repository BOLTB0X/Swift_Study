// 6번 출력
for i in 0..5 {
    print("i: " \(i));
}

// 5번 0 -> 4
// i는 0부터 시작 
for i in 0..<5 {
    print("i: " \(i));
}

// 0 -> 4 까지 짝수인 수만
for i in 0..<5 where i % 2 == 0 {
    print("i: " \(i));
}

var randomInts : [Int] = []

for _ in 0..<25 {
    let random_Number = Int.random(in: 0...1000)
    randomInts.append(random_Number)
}

print("randomInts : "\(randomInts))