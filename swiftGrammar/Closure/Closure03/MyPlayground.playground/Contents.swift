import UIKit

var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func sampleFunction(closure: () -> ()) {
    print("함수 시작")

    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {// Escaping closure captures non-escaping parameter
        closure()
    }

    print("함수 종료")
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)// 200

completionHandlers.first?()
print(instance.x) // 100

struct SomeStruct {
    var x = 10
    mutating func doSomething() {
        someFunctionWithNonescapingClosure { x = 200 } // OK
        //someFunctionWithEscapingClosure { x = 100 }    // Error
    }
}
