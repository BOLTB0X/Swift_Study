import UIKit

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)

names.sorted(by: backward)

names.sorted(by: { (s1: String, s2: String) -> Bool in
   return s1 > s2
})

names.sorted(by: { s1, s2 in return s1 > s2 })

names.sorted(by: { s1, s2 in s1 > s2 })

names.sorted(by: { $0 > $1 })

names.sorted { $0 > $1 }

let Hello = { () -> () in
    print("Hello Closure")
}

Hello() // Hello Closure

let Hello2 = { (_ name: String) in
    print("Hello Closure + \( name)")
}

Hello2("haha") // Hello Closure haha

reversedNames = names.sorted(by: { s1, s2 in return s1 > s2})

reversedNames = names.sorted(by: { $0 > $1 } )

func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}


// Here's how you call this function without using a trailing closure:


someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
})


// Here's how you call this function with a trailing closure instead:


someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}
