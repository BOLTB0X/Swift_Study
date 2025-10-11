import UIKit

let arr = [1,2,3,4]

for x in arr {
    if x == 3 {
        break
    }
}

arr.forEach { x in
    if x == 3 {
        // break
    }
}

func testForIn() {
    for x in arr {
        if x == 2 { return print("returned from function") } // 함수 종료
    }
    print("after for-in") // 실행 안됨
}

func testForEach() {
    arr.forEach { x in
        if x == 2 { return print("returned from closure") } // 클로저만 반환
    }
    print("after forEach") // 여전히 실행됨
}

testForIn()   // returned from function
testForEach() // returned from closure  / after forEach

func mayThrow(_ x: Int) throws { if x == 2 { throw NSError() } }

do {
    try arr.forEach { try mayThrow($0) }
} catch {
    print("caught")
}

func findFirstEven(_ arr: [Int]) -> Int? {
    for x in arr {
        if x % 2 == 0 {
            return x
        }
    }
    return nil
} // findFirstEven

func tryFindFirstEven(_ arr: [Int]) -> Int? {
    var found: Int?
    arr.forEach { x in
        if found != nil {
            return
        }
        if x % 2 == 0 {
            found = x
        }
    }
    return found
} // tryFindFirstEven

print(findFirstEven([1,2,3,4,8,1]))
print(tryFindFirstEven([1,2,3,4,8,1]))
