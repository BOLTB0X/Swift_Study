# Unowned Optional References(비소유 옵셔널 참조)

> 클래스에 대한 옵셔널 참조를 'Unowend '으로 표시할 수 있음

```swift
unowned var reference: SomeClass?
```

- `unowned` + `optional` 을 함께 사용하는 **참조** 방식

- **RC(참조 카운트)** 를 증가시키지 않으면서, `nil`이 될 수도 있는 **참조** 를 다루는 방식

---

## 왜 이런 개념이 사용되는가

> 보통 `unowned` 는 **non-optional** 과 함께 쓰임

```swift
unowned let owner: Owner  // 항상 owner가 존재한다고 가정 (nil이면 crash)
```

실제로,

- *어떤 객체가 "초기에는 다른 객체를 **참조** 하지 않다가"*

- *나중에 **참조** 하고, 다시 `nil` 이 될 수도 있음*

이럴 때,

- `weak`은 **옵셔널** 이지만, 보통 **순환 참조** 해결용으로만 쓰임

- `unowned` 는 **참조 카운트** 를 증가시키지 않고, `nil` 가능성도 있는 참조를 다루고 싶을 때 사용

---

## 공식문서 ex

```swift
// 1
class Department {
    var name: String
    var courses: [Course]

    init(name: String) {
        self.name = name
        self.courses = []
    }
}

// 2
class Course {
    var name: String
    unowned var department: Department
    unowned var nextCourse: Course?

    init(name: String, in department: Department) {
        self.name = name
        self.department = department
        self.nextCourse = nil
    }
}
```

1. `Department`는 `Department`에서 제공하는 각 `name` , `courses`에 대한 **강한 참조** 를 유지

2. `Course`는 `unowned` 두 개의 참조를 가짐

    - 하나는 `department`에 대한 **참조** 이고

    - 다른 하나는 학생이 수강해야 할 `nextCourse` 에 대한 **참조**

    - 모든 과목은 `Department`에 속하므로 `department` 은 **non-optional**
    
    - 일부 과목에는 권장 후속 과목이 없기 때문에 `nextCourse` 은 **optional**

---

## 참조 방식

```swift
let department = Department(name: "Horticulture")

let intro = Course(name: "Survey of Plants", in: department)
let intermediate = Course(name: "Growing Common Herbs", in: department)
let advanced = Course(name: "Caring for Tropical Plants", in: department)

intro.nextCourse = intermediate
intermediate.nextCourse = advanced
department.courses = [intro, intermediate, advanced]
```

- `intro`(입문) 및 `intermediate`(중급) `Course` 모두 `nextCourse` 프로퍼티를 갖고 있으며,

- 이 프로퍼티는 학생이 이 과목을 이수한 후 수강해야 할 과목에 대한 `unowned` **참조** 를 유지

---

<p align="center">
    <img src="https://docs.swift.org/swift-book/images/org.swift.tspl/unownedOptionalReference@2x.png" alt="Example Image" width="80%">
</p>


- **`unowned` 옵셔널 참조** 는 래핑하는 클래스의 인스턴스를 강하게 유지하지 않으므로 *ARC* 가 인스턴스를 **할당 해제** 하는 것을 막지 않음

- **`unowned` 옵셔널 참조** 는 `nil` 이 될 수 있다는 점을 제외하면 *ARC* 에서 **`unowned` 참조** 와 동일하게 동작

- **non-optional** **`unowned` 참조** 와 마찬가지로, `nextCourse` 가 항상 할당 해제되지 않은 **`Course` 인스턴스** 를 참조하도록 해야 함

    - ex, `department.courses` 에서 `course` 를 삭제할 때 다른 `courses`에서 해당 `course` 에 대한 참조를 모두 제거해야 함

---

## 참고

- [공식문서 - Unowned Optional References](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/#Unowned-Optional-References)
