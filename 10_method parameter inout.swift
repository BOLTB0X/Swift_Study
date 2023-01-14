// 매개변수 name을 받는 메소드
// _ 언더바를 넣어 메소드 호출시에 이름 안써도 됨
func sayName(_ name : String) {
    // 받은 매개변수를 이용해 출력
    print("hi?! my name is \(name)")
}

sayName("kh")

// 메소드에 매개변수로 들어오는 값은 변경
// 하지만 inout 키워드를 이용하면 값 변경 가능
func sayYourName(_ name : inout String) {
    name = "iOS를 공부하는 " + name
    print("hi?! my name is \(name)")
}

// inout 메소드에 들어가는 값은
// 변경 가능해야 되기 때문에 메소드에
// 바로 값을 넣지 못하고
// 변수에 한번 값을 담은 뒤에 넣을 것
var name = "Kh"

// inout 매개변수라고 해당 변수 앞에 &
sayYourName(&name)