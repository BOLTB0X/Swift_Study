import Foundation

class Person: NSObject {
    @objc var name: String?
}

let person = Person()

//print(person.name)

person.setValue("B0X", forKey: "name")

let name = person.value(forKey: "name")
print(name)
// Optional(B0X)

class Human: NSObject {
    @objc dynamic var name: String?
}

let human = Human()

human.observe(\.name, options: [.old, .new]) { instance, change in
  print(change.oldValue, change.newValue)
  // Optional(nil) Optional(Optional("BOX"))
}

human.name = "BOX"
print(human.name)
// Optional("BOX")
