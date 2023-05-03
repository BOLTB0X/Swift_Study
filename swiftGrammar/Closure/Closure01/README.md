# 클로저 (Closure)

> Group code that executes together, without creating a named function.
> <br/>
> 클로저 표현식은 간결하고 집중된 구문으로 인라인 클로저를 작성하는 방법, 클로저 표현식은 명확성이나 의도를 잃지 않고 짧은 형식으로 클로저를 작성하기 위한 몇 가지 구문 최적화를 제공
> <br/>

**_보통은 익명함수라 함_**
<br/>

```swift
// 노익명함수
func Hello() {
    print("Hello Closure")
}
```

<br/>

```swift
// 익명함수
let Hello = { print("Hello Closure") }
```

그러므로 Closure라고 하면 Unnamed Closure라고도 함
<br/>

## 표현식

```swift
{ Parametor -> Return Type in // 클로저 헤드
    code // 클로저 바디
}
```

- func 키워드 작성 X
  <br/>

- 클로저 헤드
  <br/>

- 클로저 바디
  <br/>

- in을 통해 구분
  <br/>

## 클로저의 여러 형태

<br/>

#### 파라미터와 리턴 값 존재 X

```swift
let Hello = { () -> () in
    print("Hello Closure")
}

Hello() // Hello Closure
```

<br/>

#### 파라미터와 리턴 값 존재 O

```swift
let Hello = { (name: String) -> String in
    print("Hello Closure + \( ame)")
}

Hello("haha") // Hello Closure haha
```

<br/>

## 트레일링 클로저(Trailing Closure)

함수의 마지막 파라미터가 클로저일 때, 이를 파라미터 값 형식이 아닌 함수 뒤에 붙여 작성된 클로저(Argument Label은 생략)
<br/>

#### 클로저를 파라미터로

```swift
func HelloFunc(closure: () -> ()) {
    closure()
}

HelloFunc(closure: { () -> () in
    print("Hello Closure")
})
```

<br/>

즉 이 코드는 함수의 파라미터에 클로저를 전달 받아 함수가 호출 될 시, 클로처가 실행
<br/>

#### return Type에 클로저

```swift
func HelloFunc() -> () -> () {
    return { () -> () in
        print("Hello Closure")
    }
}

HelloFunc()() // Hello Closure
```

<br/>

이런식 후행 클로저 사용
<br/>

#### 파라미터가 여러 개인 클로저

```swift
func fetch(success:() -> (), fail: -> () -> ()) {
    // Code
}

fetch(success: { () -> () in
    print("성공")
}, fail: { () - > () in
    print("실패")
})
```

<br/>

주로 API 호출하거나 Combine 등에서 자주보는 형태
<br/>

## 축약한 형태

```swift
func sumFunc(closure: (Int, Int, Int) -> Int) {
    closure(1,2,3)
}

sumFunc(closure: {(a, b, c) in
    return a+b+c
})

sumFunc(closure: {
    return $0+$1+$2
})

sumFunc(closure: {
    $0+$1+$2
})

sumFunc() {
    $0+$1+$2
}

sumFunc {
    $0+$1+$2
}
```

-

## 참고

https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/
<br/>
https://didu-story.tistory.com/173
<br/>
https://babbab2.tistory.com/81
<br/>
