# if let 와 guard

둘다 주로 옵셔널 값을 처리하고, 코드의 가독성과 안정성을 높이는 데 사용
<br/>

## if let

> guard 문과 같은 가드 문은 표현식의 Bool 값에 따라 문을 실행합니다. 조건문과 옵셔널 관련하여 사용할 때 유용합니다.
> <br/>
> guard문과 달리 else를 꼭 안 붙여도 됩니다.
> <br/>

if let 구문은 옵셔널 값을 언래핑하고, 값이 존재할 경우 특정 블록 내에서 사용하는 데 사용
<br/>

값이 존재하지 않는 경우 해당 블록이 실행되지 않고 주로 조건문 안에서 옵셔널 값이 필요한 경우 사용
<br/>

```swift
func greet(person: [String: String]) {
    if let name = person["name"] {
        print("Hello \(name)!")
    } else {
        return
    }

    if let location = person["location"] {
        print("I hope the weather is nice in \(location).")
    } else {
        print("I hope the weather is nice near you.")
        return
    }
}


greet(person: ["name": "John"])
// "Hello John!"
// "I hope the weather is nice near you."
greet(person: ["name": "Jane", "location": "Cupertino"])
// "Hello Jane!"
// "I hope the weather is nice in Cupertino."
```

## guard

> if 문과 같은 가드 문은 표현식의 Bool 값에 따라 문을 실행합니다. Guard 문 뒤의 코드가 실행되려면 조건이 참이어야 함을 요구하려면 Guard 문을 사용합니다.
> <br/>
> if 문과 달리 Guard 문에는 항상 else 절이 있습니다. else 절 내부의 코드는 조건이 true가 아닌 경우 실행됩니다.
> <br/>

옵셔널 값을 언래핑하고, 값이 존재할 경우 계속해서 함수나 블록을 실행하게 하는 게 **guard**
<br/>

값이 존재하지 않을 경우, 조건이 충족되지 않은 것으로 간주하여 빠르게 함수나 코드 블록을 종료(if-let과 주요 차이)
<br/>

주로 함수 내에서 초기값이 필요한 경우나, 필수적인 조건이 충족되지 않으면 더 이상 실행하지 않아야 할 경우 사용
<br/>

return, break, continue 또는 throw와 같은 제어 전송 문을 사용하여 이를 수행하거나 fatalError(\_:file:line:)와 같이 반환하지 않는 함수나 메서드를 호출 가능
<br/>

```swift
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }


    print("Hello \(name)!")


    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }


    print("I hope the weather is nice in \(location).")
}


greet(person: ["name": "John"])
// "Hello John!"
// "I hope the weather is nice near you."
greet(person: ["name": "Jane", "location": "Cupertino"])
// "Hello Jane!"
// "I hope the weather is nice in Cupertino."
```

## 차이점

- if let은 값이 존재하던 없던 간에 블록 내에서 옵셔널 값을 사용할 수 있지만 guard는 값이 존재해야만 뒤의 코드를 사용 가능
  <br/>

- guard는 종종 초기조건을 검사하고, 이를 만족하지 않으면 빠르게 코드 실행을 종료시키는 데 사용 됌, if let은 더 유연한 방식으로 값을 다루고 가독성 측명에서 좋게 사용이 가능
  <br/>

## 참고

[swift 공식문서 -Early Exit-](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow/)
