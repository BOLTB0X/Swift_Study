import UIKit

print("1")
DispatchQueue.main.async {
    print("슈우우우우우ㅜ우우웅1")
 
}
print("2")
DispatchQueue.main.async {
    print("슈우우우우우ㅜ우우웅2")
 
}
print("3")
 
DispatchQueue.main.async {
    print("슈우우우우우ㅜ우우웅3")
}

// 1
// 2
// 3
// 슈우우우우우ㅜ우우웅1
// 슈우우우우우ㅜ우우웅2
// 슈우우우우우ㅜ우우웅3

print("--------------------------------------------")

var serialQueue = DispatchQueue(label: "SerialQueue")
print("1")
serialQueue.async {
    print("슈우우우우우ㅜ우우웅1")
}
print("2")
serialQueue.async {
    print("슈우우우우우ㅜ우우웅2")
}
print("3")
serialQueue.async {
    print("슈우우우우우ㅜ우우웅3")
}
print("4")
serialQueue.async {
    print("슈우우우우우ㅜ우우웅4")
}
print("5")
serialQueue.async {
    print("슈우우우우우ㅜ우우웅5")
}
print("6")
serialQueue.async {
    print("슈우우우우우ㅜ우우웅6")
}

//1
//슈우우우우우ㅜ우우웅1
//2
//3
//4
//5
//6
//슈우우우우우ㅜ우우웅2
//슈우우우우우ㅜ우우웅3
//슈우우우우우ㅜ우우웅4
//슈우우우우우ㅜ우우웅5
//슈우우우우우ㅜ우우웅6
//슈우우우우우ㅜ우우웅1
//슈우우우우우ㅜ우우웅2
//슈우우우우우ㅜ우우웅3

print("--------------------------------------------")

var defaultQueue = DispatchQueue.global(qos: .background)
print("1")
defaultQueue.async {
    print("슈우우우우우ㅜ우우웅1")
}
print("2")
defaultQueue.sync {
    print("슈우우우우우ㅜ우우웅2")
}
print("3")
defaultQueue.async {
    print("슈우우우우우ㅜ우우웅3")
}
print("4")
defaultQueue.sync {
    print("슈우우우우우ㅜ우우웅4")
}

print("-------------------------------------")

DispatchQueue.global(qos: .background).sync {
    for item in 1...10 {
        print("sync : \(item)")
    }
}
 
for item in 50...60 {
    print(item)
}

// sync : 1
//sync : 2
//sync : 3
//sync : 4
//sync : 5
//sync : 6
//sync : 7
//sync : 8
//sync : 9
//sync : 10
//50
//51
//52
//53
//54
//55
//56
//57
//58
//59
//60

print("----------------------------------")

DispatchQueue.global(qos: .background).async {
    for item in 1...10 {
        print("Async (1) : \(item)")
    }
}
 
DispatchQueue.global(qos: .background).async {
    for item in 30...40 {
        print("Async (2) : \(item)")
    }
}
 
for item in 90...100 {
    print(item)
}

//90
//Async (1) : 1
//91
//Async (2) : 30
//92
//Async (1) : 2
//93
//Async (2) : 31
//Async (1) : 3
//94
//Async (1) : 4
//Async (2) : 32
//Async (1) : 5
//95
//Async (2) : 33
//96
//Async (1) : 6
//97
//Async (2) : 34
//98
//Async (1) : 7
//99
//Async (2) : 35
//100
//Async (2) : 36
//Async (1) : 8
//Async (2) : 37
//Async (1) : 9
//Async (2) : 38
//Async (2) : 39
//Async (1) : 10
//Async (2) : 40
//슈우우우우우ㅜ우우웅1
//슈우우우우우ㅜ우우웅2
//슈우우우우우ㅜ우우웅3

print("--------------------------------------------------")
DispatchQueue.global(qos: .userInteractive).async {
    for item in 1...10 {
        print("Async (1) : \(item)")
    }
}
 
DispatchQueue.global(qos: .background).async {
    for item in 30...40 {
        print("Async (2) : \(item)")
    }
}
 
for item in 90...100 {
    print(item)
}

//90
//Async (1) : 1
//91
//Async (1) : 2
//92
//Async (1) : 3
//93
//Async (1) : 4
//94
//Async (1) : 5
//95
//Async (1) : 6
//Async (1) : 7
//96
//97
//Async (1) : 8
//98
//99
//Async (1) : 9
//100
//Async (1) : 10
//Async (2) : 30
//Async (2) : 31
//Async (2) : 32
//Async (2) : 33
//Async (2) : 34
//Async (2) : 35
//Async (2) : 36
//Async (2) : 37
//Async (2) : 38
//Async (2) : 39
//Async (2) : 40
