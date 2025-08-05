import UIKit

class HTMLElement {
    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
            [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
//    lazy var asHTML: () -> String = { [weak self] in
//        guard let self = self else {
//            return "<unknown />"
//        }
//
//        if let text = self.text {
//            return "<\(self.name)>\(text)</\(self.name)>"
//        } else {
//            return "<\(self.name) />"
//        }
//    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }


    deinit {
        print("\(name) is being deinitialized")
    }

}

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// "<p>hello, world</p>"

//var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
//print(paragraph!.asHTML()) // <p>hello, world</p>
//
//paragraph = nil
