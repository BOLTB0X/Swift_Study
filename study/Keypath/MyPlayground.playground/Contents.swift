import Foundation

class Person {
    var name: String = "B0X"
}

let person = Person()
let nameKeyPath = \Person.name

// KeyPath Read
print(person[keyPath: nameKeyPath])
// B0X

// KeyPath Write
person[keyPath: nameKeyPath] = "BOLT"
print(person.name)
// BOLT
