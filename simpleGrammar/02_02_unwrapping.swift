// 옵셔널 변수 언랩핑
var someVariable : Int?

// 값이 비어있다면 변수에 값을 넣음
if someVariable == null {
    someVariable = 90
}

if let otherVariable = someVariable {
    print("값이 있다. otherVariable : \(otherVariable)")
}

else {
    print("값이 없다.")
}

someVariable = nil
// someVariable에 값이 없다면 기본 값으로 다른 값 넣음
let myValue = someVariable ?? 10
print("myValue : \(myValue)")

var emptyVariable : Int?

myFunction(parameter: myValue)
myFunction(parameter: emptyVariable)

func myFunction(parameter: Int?) {
    print("myFunction() called")

    // 값이 없다면 리턴
    guard let unWrappedParam = parameter else {
        return         
    }

    print("unWrappedParam: \(unWarppedParam)")
}