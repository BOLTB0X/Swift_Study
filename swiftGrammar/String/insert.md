## insert(\_:at:)

> Inserts a new character at the specified position.
> <br/>
> 지정된 위치에 새 문자를 삽입
> <br/>

```swift
var ssstr = "Kofi"

// 문자열의 인덱스는 정수값이 아니기 때문에
let i = ssstr.index(ssstr.startIndex, offsetBy: 4)
ssstr.insert("K", at: i) //KKofi

print(ssstr)

```

TODO

---

## 참고

https://developer.apple.com/documentation/swift/string/insert(_:at:)-1uqvy
<br/>
https://soooprmx.com/swift-swift의-string타입-기초-02-문자열-조작/
<br/>
