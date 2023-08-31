# 옵셔널(Optional)

## Optional이란?

> A type that represents either a wrapped value or the absence of a value.
> <br/>
> Optional 값을 사용할 때마다 Optional 유형을 사용
> <br/>

값이 있을 수도, 없을 수도 있는 변수
<br/>

옵셔널 변수를 선할 때 뒤에 **?** 붙여두면 됌
<br/>

## Optional 선언

```swift
let shortForm: Int? = Int("42")
let longForm: Optional<Int> = Int("42")
```

- Optional 유형은 두 가지 경우가 있는 열거형
  <br/>
- optional.none은 nil 리터럴과 동일
  <br/>

## Optional Unwrapping(옵셔널 언래핑)

옵셔널로 감싸진 옵셔널이 아닌 값을 추출하는 작업
<br/>

```swift
let number: Int? = Optional.some(42)
let noNumber: Int? = Optional.none
print(noNumber == nil)
// true
```

Optional.some(Wrapped)은 래핑된 값을 저장하려면 위 코드 처럼 해주면 됌
<br/>

JSON값들 처럼 실무에서 API를 이용할떄 옵셔널 처리를 많이 보게 됌
<br/>
Optional 인스턴스의 값을 언래핑해야 하는 것은 꼭 받는 게 아닌 nill 수도 있고 그래서 무조건 명시해줘야함

## Optional Binding

> Optional 인스턴스의 래핑된 값을 새 변수에 조건부로 바인딩하려면 if let, guard let 및 switch를 포함하여 선택적 바인딩 제어 구조 중 하나를 사용
> <br/>

### if let 구조

```swift
// if let
let a: Int? = 4
if let tmp = a {
   // a가 nil이 아닐 때
   print(tmp)
} else {
   // a가 nil일 때
   print(a)
}
```

안전하게 옵셔널 값을 언래핑 하는 방법
<br/>

- 옵셔널 표현식 작성 (if let 임시상수 = 옵셔널값 또는 guard let 임시상수 = 옵셔널값) 타입 추론이 되므로 타입 어노테이션은 대부분 생략
  <br/>

- 옵셔널값이 nil이 아니라면 : 임시상수에 옵셔널 언래핑된 값이 저장되고, true 반환
  <br/>

- 옵셔널값이 nil이라면 : false 반환
  <br/>

여기서 a는 언래핑하더라도 옵셔널인걸 잊으면 안됌
<br/>

### if let - 여러 개의 옵셔널값 바인딩 및 조건 추가

```swift
// if let 여러 개의 옵셔널값 바인딩 및 조건 추가
let name: String? = nil
let age: Int? = nil

if let name = name, let age = age, age > 5 {
    // name과 age 가 모두 nil이 아니고, age가 5보다 커야 if 구문이 true가 됨.
}
```

### guard let

```swift
func funcGuard(age: Int?) {
    guard let unwrappedAge = age,
        unwrappedAge < 130,
        unwrappedAge >= 0 else {
        print("나이값 입력이 잘못되었습니다")
        return
    }

    print("당신의 나이는 \(unwrappedAge)세입니다")
}
// "옵셔널숫자" 가 nil이 아님
// 이 스코프에서 "임시상수" 사용 가능
```

- 특성상 함수(메서드)에서만 주로 사용
  <br/>

- guard문의 조건을 만족하지 못하면 else문으로 처리되며, 함수는 리턴
  <br/>

- 반드시 else와 함께 사용 -> 조건 불만족시 리턴시켜야 하기 때문
  <br/>
  guard 조건을 만족하지 못하면 함수 내로 들어오지 못하도록 가드 역할
  <br/>

### guard let - 여러 개의 옵셔널값 바인딩 및 조건 추가

```swift
func functest(_ name: String?, _ age: Int?) {
   guard let name = name, let age = age, age < 5 else {
      return
   }
}
```

### if let과 guard let 차이

#### if let

- 옵셔널 값 있으면 if구문에서 처리하고, nil이면 else에서 처리하고 싶을 때 사용
- 옵셔널 값의 경우에 대한 피드백을 제공할 때 사용

#### guard let

- 옵셔널 값 있으면 계속 진행하고, 없으면 내 함수에서 나가고 싶을 때 사용
- 옵셔널 값이 nil인 경우 무조건 함수를 종료시키고 싶을 때 사용

## Forced Unwrapping(강제 추출)

```swift
let tmp = Int(a)! // 이런식
```

옵셔널의 실제 값에 상관없이 강제로 값을 추출
<br/>

## Implicitly Unwrapped Optional(옵셔널 묵시적 추출)

> 옵셔널 타입을 옵셔널이 아닌 타입에 대입할 때 강제 추출이나 옵셔널 바인딩처럼, 별도의 추출 과정을 거치지 않아도 자동으로 옵셔널이 해제되는 방법
> <br/>

```swift
var num1: Int? = 4
var num2: Int = num1
// 에러 발생
// 옵셔널 타입을 옵셔널이 아닌 타입에 대입하려 하기 때문

var num3: Int! = 4 // IUO 사용
var num4: Int = num3 // num2의 값은 4이다
// 정상 작동 -
// IUO를 사용했기 때문
```

쓰는 이유가 "프로퍼티 지연 초기화"를 하기위해서라고 함
<br/>
BOutlet, API 에서 IUO를 리턴한 경우에 주로 사용

## Nil-Coalescing Operation(?? 연산자 - nil 병합 연산자)

> 옵셔널값 ?? 기본값
> <br/>

옵셔널 값이 nil이 아니면 옵셔널을 언래핑한 값을, nil이면 ?? 뒤의 기본값을 사용
<br/>
옵셔널값 과 기본값은 옵셔널을 벗기면 동일한 타입이어야 사용 가능
<br/>

## 참고 및 도움을 준

https://velog.io/@bibi6666667/Swift-옵셔널-언래핑-방법들-정리
https://developer.apple.com/documentation/swift/optional
