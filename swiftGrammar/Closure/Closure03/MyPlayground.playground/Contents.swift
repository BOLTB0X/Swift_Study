import UIKit

// 클로저 외부에서 변경하는 경우
func somethingInFunc() {
    var n = 0
    print("1: \(n)")

    let closure = { // 외부 변수 n을 클로저 내부에서 캡처함
        print("3: \(n)") // 이를 Reference Capture
        
    }
    
    n = 10
    print("2: \(n)")
    closure()
}

somethingInFunc()
// 1: 0
// 2: 10
// 3: 10

print("-------------------------------------")

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10) // incrementByTen은 makeIncrementer 라는 함수를 호출해서 반환된 클로저

print(incrementByTen()) // returns a value of 10
print(incrementByTen()) // returns a value of 20
print(incrementByTen()) // returns a value of 30

let incrementBySeven = makeIncrementer(forIncrement: 7)
print(incrementBySeven()) // returns a value of 7

print(incrementByTen()) // returns a value of 40

print("-------------------------------------")

// 클로저 내부에서 변경하는 경우
func somethingOutFunc() {
    var n = 0
    print("1: \(n)")

    let closure = { // 외부 변수 n을 클로저 내부에서 캡처함
        n = 20 // 내부에서 변경
        print("3: \(n)") // 이를 Reference Capture
        
    }
    
    closure()
    print("2: \(n)")
}

somethingOutFunc()
// 1: 0
// 2: 20
// 3: 20
