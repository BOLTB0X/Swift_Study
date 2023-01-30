import UIKit

// Assertion
// assert(_:_:file:line:) 함수를 사용
// assert 함수는 디버깅 모드에서만 동작
// 배포하는 애플리케이션에서는 제외
// 예상했던 조건의 검증을 위하여 사용

var someInt: Int = 0

// 검증 조건과 실패시 나타날 문구를 작성
// 검증 조건에 부합하므로 통과
assert(someInt == 0, "someInt != 0")

someInt = 1
//assert(someInt == 0) // 동작 중지, 검증 실패
//assert(someInt == 0, "someInt != 0") // 동작 중지, 검증 실패
// assertion failed: someInt != 0: file guard_assert.swift, line 26


func functionWithAssert(age: Int?) {
    
    assert(age != nil, "age == nil")
    
    assert((age! >= 0) && (age! <= 130), "나이값 입력이 잘못되었습니다")
    print("당신의 나이는 \(age!)세입니다")
}

functionWithAssert(age: 50)
//functionWithAssert(age: -1) // 동작 중지, 검증 실패
//functionWithAssert(age: nil) // 동작 중지, 검증 실패
