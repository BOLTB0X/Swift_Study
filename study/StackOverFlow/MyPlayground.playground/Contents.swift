import UIKit

func mainFunc() {
    Func1() // 함수 1 호출
}

func Func1() {
    Func2() // 함수 2 호출
}

func Func2() {
    
}

// 파라미터로 전달해온 a를 1씩 증가시켜주는 함수
func plusOne(_ a: Int) {
    if a == 0 {
        return
    }
    var a = a // 참고로 매개변수는 let
    
    a += 1
    print(a)
    plusOne(a)
}

func makeA() {
    let a:Int = 0
    plusOne(a)
}

makeA() // 무한히 호출
