import UIKit
import Foundation

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// 5


let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// 5


print("Now serving \(customerProvider())!")
// Now serving Chris!

print(customersInLine.count)
// 4

func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}

serve(customer: { customersInLine.remove(at: 0) })

func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}

serve(customer: customersInLine.remove(at: 0))

class CustomerManager {
    private(set) var customerProviders: [() -> String] = []

    func collect(_ provider: @autoclosure @escaping () -> String) {
        customerProviders.append(provider)
    }

    func serveAll() {
        print("Collected \(customerProviders.count) closures.")
        for provider in customerProviders {
            print("Now serving \(provider())!")
        }
    }
}

let manager = CustomerManager()

// 고객 등록 (autoclosure 덕분에 괄호 없이 remove 호출 가능)
manager.collect(customersInLine.remove(at: 0)) // Chris
manager.collect(customersInLine.remove(at: 0)) // Alex

manager.serveAll()
// Collected 2 closures.
// Now serving Chris!
// Now serving Alex!
