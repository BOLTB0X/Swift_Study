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

func outFunc(closure: () -> ()) -> () -> () {
    func localFunc() {
        closure()
    }

    return inFunc() // Escaping local function cpatures non-escaping parameter 'closure'
}
