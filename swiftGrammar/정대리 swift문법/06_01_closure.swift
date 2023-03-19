// String을 반환하는 클로저
let myName : String = {
    // 이 부분이 myName으로 들어감
    return "B0X"
} ()
print(myName)

let yourName : String = {
    // 이 부분이 myName으로 들어감
    return "BOLT"
} ()
print(yourName)

// 매개변수를 가지고 String으로 반환하는 클로저
let myRealNameString = { (name : String) -> String in 
    return "발악하는 \(name)"
}
print(myRealNameString("BOLTB0X"))

// 클로저가 print 로직을 담고 있을 때
let name = {
    print("BOLTB0X")
}

name()

let myRealName = { (name : String) in
    print("발악하는 \(name)")
}

myRealName("BOLTB0x")