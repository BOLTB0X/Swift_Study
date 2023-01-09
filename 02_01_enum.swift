enum School {
    // case elemetary
    // case middle
    // case high
    // 한 번에 가능
    case elemetary, middle, high 
}

let yourSchool = School.elemetary
print("yourSchool : \(yourSchool)")
// elemetary 출력

enum Grade : Int {
    case first = 1
    case second = 2
}

let yourGrade = Grade.second
print("yourGrade : \(yourGrade)")
// 2 출력

enum SchoolDetail {
    case elemetary(name: String)
    case middle(name: String)
    case high(name: String)

    // 함수 이용
    func getName() -> String {
        switch self {
        case .elementary(let name):
            return name
        case let .middle(name):
            return name
        }
    }
}

let yourMiddleSchoolName = SchoolDetail.middle(name: "H중학교")
print("yourMiddleSchoolName: \(yourMiddleSchoolName.getName())")