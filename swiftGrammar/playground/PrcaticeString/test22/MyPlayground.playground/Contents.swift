import UIKit

let str = "ABCDEFG"
str[str.startIndex] // A
str[str.index(after: str.startIndex)] // B
str[str.index(before: str.endIndex)] // G

let s = "Swift"
if let i = s.index(s.startIndex, offsetBy: 4, limitedBy: s.endIndex) {
    print(s[i])
}

let j = s.index(s.startIndex, offsetBy: 6, limitedBy: s.endIndex)
print(j)

var students = ["Ben", "Ivy", "Jordell", "Maxime"]
if let i = students.firstIndex(of: "Maxime") {
    students[i] = "Max"
}
print(students) // "["Ben", "Ivy", "Jordell", "Max"]"

let students2 = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]

if let i = students2.firstIndex(where: { $0.hasPrefix("A") }) {
    print("\(students2[i]) starts with 'A'!") // "Abena starts with 'A'!"
}

var students3 = ["Ben", "Ivy", "Jordell", "Ben", "Maxime"]

if let i = students3.lastIndex(of: "Ben") {
    students3[i] = "Benjamin"
}

print(students3) // "["Ben", "Ivy", "Jordell", "Benjamin", "Max"]"

let students4 = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]

if let i = students4.lastIndex(where: { $0.hasPrefix("A") }) {
    print("\(students4[i]) starts with 'A'!") // "Akosua starts with 'A'!"
}
