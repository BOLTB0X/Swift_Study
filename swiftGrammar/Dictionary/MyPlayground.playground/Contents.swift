import Foundation

var responseMessages = [200: "OK",
                        403: "Access forbidden",
                        404: "File not found",
                        500: "Internal server error"]

var emptyDict: [String: String] = [:]

print(responseMessages[200])
// Optional("OK")


let httpResponseCodes = [200, 403, 301]
for code in httpResponseCodes {
    if let message = responseMessages[code] {
        print("Response \(code): \(message)")
    } else {
        print("Unknown response \(code)")
    }
}
// Response 200: OK
// Response 403: Access forbidden
// Unknown response 301

responseMessages[301] = "Moved permanently"
print(responseMessages[301])
// Optional("Moved permanently")

responseMessages[404] = "Not found"
responseMessages[500] = nil
print(responseMessages)
// [403: "Access forbidden", 200: "OK", 404: "Not found", 301: "Moved permanently"]

for (k, v) in responseMessages {
    print("\(k) : \(v).")
}

//301 : Moved permanently.
//200 : OK.
//403 : Access forbidden.
//404 : Not found.

var interestingNumbers = ["primes": [2, 3, 5, 7, 11, 13, 17],
                          "triangular": [1, 3, 6, 10, 15, 21, 28],
                          "hexagonal": [1, 6, 15, 28, 45, 66, 91]]
for key in interestingNumbers.keys {
    interestingNumbers[key]?.sort(by: >)
}


print(interestingNumbers["primes"]!)
// [17, 13, 11, 7, 5, 3, 2]

print(interestingNumbers.count)
// 3


var dict1 = ["height": 165, "age" : 100]
var dict2 = ["height": 165, "age" : 100]
var dict3 = ["Height": 165, "Age" : 100]
var dict4 = ["name": "sodeul", "address" : "Suwon"]
 
print(dict1 == dict2)
print(dict1 == dict3)
// print(dict1 == dict4) // Error: inary operator '==' cannot be applied to operands of type '[String : Int]' and '[String : String]'

let condition: ((String, Int)) -> Bool = {
    $0.0.contains("h")
}
 
print(dict1.contains(where: condition))
// true
 
print(dict1.first(where: condition))
// Optional((key: "height", value: 165))
 

print(dict1.filter(condition))
// ["height": 165]

for key in responseMessages.keys {
    print(key)
//    200
//    301
//    403
//    404
}

for value in responseMessages.values {
    print(value)
//    Ok
//    Moved permanently
//    Access forbidden
}

print(responseMessages)

responseMessages.removeValue(forKey: 404)

print(responseMessages)

//[200: "OK", 301: "Moved permanently", 403: "Access forbidden", 404: "Not found"]
//[200: "OK", 301: "Moved permanently", 403: "Access forbidden"]
