## 특정 문자의 인덱스를 찾는 함수

### firstIndex

1. firstIndex(of: Character)

   > Returns the first index where the specified value appears in the collection.
   > <br/>

   인자로 들어온 문자가 첫번째에서 몇번째 인덱스에 있는지 (Optional)로 반환해줌
   <br/>
   배열에서도 사용 가능
   <br/>

```swift
let tmpstr = "hello swift"

// 인덱스를 0부터 셈
if let index = tmpstr.firstIndex(of: "o") {
    print(index) // 4
}
```

<br/>

```swift
var students = ["Ben", "Ivy", "Jordell", "Maxime"]

if let i = students.firstIndex(of: "Maxime") {
    students[i] = "Max"
}
print(students) // Prints "["Ben", "Ivy", "Jordell", "Max"]"
```

<br/>

2. firstIndex(where:)

   > Returns the first index in which an element of the collection satisfies the given predicate.
   > <br/>

   컬렉션의 요소가 주어진 조건자를 만족하는 첫 번째 인덱스를 반환
   <br/>

```swift
let students = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]


if let i = students.firstIndex(where: { $0.hasPrefix("A") }) {
    print("\(students[i]) starts with 'A'!")
}
```

### lastIndex

1. lastIndex(of: Character)

   > Returns the last index where the specified value appears in the collection.
   > <br/>

   인자로 들어온 문자가 마지막에서 몇번째 인덱스에 있는지 (Optional)로 반환해줌
   <br/>
   배열에서도 사용 가능
   <br/>

```swift
if let index = tmpstr.lastIndex(of: "o") {
    print(index)
}
```

    배열 안의 문자열로도 가능
    <br/>

```swift
var students = ["Ben", "Ivy", "Jordell", "Ben", "Maxime"]

if let i = students.lastIndex(of: "Ben") {
    students[i] = "Benjamin"
}

print(students) // ["Ben", "Ivy", "Jordell", "Benjamin", "Max"]"
```

2. lastIndex(where:)

   > Returns the index of the last element in the collection that matches the given predicate.
   > <br/>

   지정된 특정 것과 일치하는 컬렉션의 마지막 요소 인덱스를 반환
   <br/>
