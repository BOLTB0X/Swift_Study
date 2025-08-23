import Foundation
import SwiftUI

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

struct MyStruct: SomeProtocol {
    var mustBeSettable: Int
    var doesNotNeedToBeSettable: Int {  // 읽기 전용은 계산 속성으로 구현
        return mustBeSettable * 2
    }
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Appleseed")
// john.fullName is "John Appleseed"

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
// ncc1701.fullName is "USS Enterprise"

protocol SomeProtocol2 {
    static func someTypeMethod()
}

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)
            .truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")

// "Here's a random number: 0.3746499199817101"
print("And another one: \(generator.random())")
// "And another one: 0.729023776863283"

protocol Togglable {
    mutating func toggle()
}


enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
// lightSwitch is now equal to .on

protocol SomeProtocol3 {
    init(someParameter: Int)
}

class SomeClass: SomeProtocol3 {
    required init(someParameter: Int) {
        // initializer implementation goes here
    }
}

protocol SomeProtocol4 {
    init()
}

class SomeSuperClass {
    init() {
        // initializer implementation goes here
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocol4 {
    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
        // initializer implementation goes here
    }
}

struct MyStruct2: Copyable {
    var counter = 12
}

extension MyStruct2: BitwiseCopyable { }

protocol Drawable {
    func draw()
}

func render<T: Drawable>(_ item: T) {
    item.draw()
}


// 프로토콜을 따르는 구체 타입
struct Circle: Drawable {
    func draw() {
        print("그려그려그려 원을~")
    }
}

struct Square: Drawable {
    func draw() {
        print("그려그려그려 사각형을~")
    }
}

//  불투명 타입 (Opaque Type) 사용
func makeShape() -> some Drawable {
    return Circle()
}

// 박스형 프로토콜 타입 (Existential Type) 사용
func testExistential() {
    var shape: Drawable = Circle()  // Circle을 할당
    shape.draw()
    
    shape = Square()  // 런타임 시점에 다른 타입으로 교체 가능
    shape.draw()
}

let s = makeShape()
s.draw()

testExistential()
