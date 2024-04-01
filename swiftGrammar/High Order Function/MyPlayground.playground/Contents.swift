import Foundation

let cast = ["Vivien", "Marlon", "Kim", "Karl"]
let lowercaseNames = cast.map { $0.lowercased() }
print(lowercaseNames) // ["vivien", "marlon", "kim", "karl"]

let letterCounts = cast.map { $0.count }
print(letterCounts) // [6, 6, 3, 4]

func countElements(array: [String]) -> [String: Int] {
    var ret: [String : Int] = [:]
    
    array.map {
        ret[$0, default: 0] += 1
    }
    
    return ret
}
let array3 = ["a", "b", "a", "c", "b", "d"]
print(countElements(array: array3)) // ["c": 1, "d": 1, "a": 2, "b": 2]

func addStars(array: [String]) -> [String] {
    array.map { "*" + $0 + "*"}
}

let array5 = ["a", "b", "c"]
print(addStars(array: array5))

func capitalize(_ string: String) -> String {
    //string.capitalized
    
    string.components(separatedBy: " ")
        .map {
            if let ch = $0.first {
                return String(ch).uppercased() + $0.dropFirst()
            } else {
                return $0
            }
        }.joined(separator: " ")
}

let sentence = "this is a test"
let capitalizedSentence = capitalize(sentence)
print(capitalizedSentence)      // "This Is A Test"

let array6 = [1, 2, 3]

let array7 = array6.map {
    if $0 % 2 == 0  {
        return $0 * 2
    } else {
        return $0 * 2 + 1
    }
}

print(array7) // [3, 4, 7]

let shortNames = cast.filter { $0.count < 5 }
print(shortNames)
shortNames.contains("Vivien") // false


let array8 = [1, 2, 3, 4, 5, 6, 7, 8, 9]
print(array8.filter { $0 % 3 == 0}) // [3, 6, 9]

print("This is a test".filter{ $0 != " " }) // Thisisatest

let dict = ["apple": 5, "banana": 3, "orange": 7, "grape": 2]
print(dict.filter { $0.value > 3 })

let numbers = [1, 2, 3, 4]
var numberRes = numbers.reduce(0, { x, y in
    x + y + x + x + y + y - 1
})

numberRes = numbers.reduce(0, { $0 + $1})

print(numberRes) // 134

print(numbers.reduce(0, +)) // 10
print(numbers.reduce(0, -)) // -10
print(numbers.reduce(1, *)) // 24
print(numbers.reduce(1, /)) // 0

let students: Set = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
let sortedStudents = students.sorted()
print(sortedStudents) // "["Abena", "Akosua", "Kofi", "Kweku", "Peter"]"

struct Person {
    let name: String
    let age: Int
}

let people = [
    Person(name: "k", age: 30),
    Person(name: "h", age: 29),
    Person(name: "lee", age: 40)
]

let sortedPeople = people.sorted { $0.name < $1.name }

let sortedPeople2 = people.sorted {
    if $0.age == $1.age {
        return $0.name < $1.name
    }
    return $0.age < $1.age
}

print(sortedPeople2)

let number = [3, 1, 4, 1, 5, 9, 2, 6, 5]

let sortedNumber = number.sorted { num1, num2 in
    if num1 % 2 != num2 % 2 { // 홀수와 짝수를 구분하여 정렬
        return num1 % 2 == 0 // 홀수가 짝수보다 작은 것으로 간주
    } else {
        return num1 < num2 // 같은 유형의 숫자는 크기에 따라 정렬
    }
}

print(sortedNumber) // [1, 1, 3, 5, 5, 9, 2, 4, 6]

let tuples = [(2, "k"), (1, "h"), (3, "l")]


let sortedTuples = tuples.sorted {
    if $0.0 == $1.0 {
        return $0.1 < $1.1 // 같은 숫자일 때 문자열을 기준으로 정렬
    } else {
        return $0.0 < $1.0
    }
}

print(sortedTuples) // [(1, "h"), (2, "k"), (3, "l")]

let strDic = "appleisgood".reduce(into: [:]) {
    $0[$1, default: 0] += 1
}

print(strDic) // "a": 1, "o": 2, "i": 1, "d": 1, "p": 2, "e": 1, "l": 1, "s": 1, "g": 1]

let numberWords = ["one", "two", "three"]

numberWords.forEach { word in
    print(word)
    // one
    // two
    // three
}

let ar = [1, 2, 3, 4]

let mapped = ar.map { Array(repeating: $0, count: $0) }
// [[1], [2, 2], [3, 3, 3], [4, 4, 4, 4]]

let flatMapped = ar.flatMap { Array(repeating: $0, count: $0) }
// [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
