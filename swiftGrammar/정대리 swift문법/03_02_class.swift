class Student {
    var name : String
    var id : Int
    
    // init 으로 매개변수 가진 생성자 매소드를 만들어야 매개변수 넣고 객체생성 가능
    init(name : String, id : Int) {
        self.name = name
        self.id = id
    }
}

var Ahigh = Student(name : "Lhh", id : 12)
var backup = Ahigh
backup.name = "Lkh"

print("class - backup.name : \(backup.name)") // Lkh
print("class - Ahigh.name : \(Ahigh.name)") // Lhh