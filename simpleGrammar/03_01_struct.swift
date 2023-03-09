struct Student {
    var name : String
    var id : Int
}

var Hmiddle = Student(name: "Lkh", id: 11)
var hmidde_backup = Hmiddle

print("struct - Hmiddle.name : \(Hmiddle.name)") // Lkh
var hmidde_backup.name = "Lkk"

print("struct - Hmiddle.name : \(Hmiddle.name)") // Lkh
print("struct - hmiddle_backup.name : \(hmiddle_backup.name)") // Lkh
