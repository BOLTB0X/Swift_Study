// 정의
func basic_Func(name : String) -> String {
    return "안녕하새요 ? \(name) 이에요~~"
}

// 매개변수 이름 설정 가능
func another_Func(myName name : String) -> String {
    return "안녕하세요 !? \(name) 입니다!"
}

// 함수 호출시 매개변수 이름 없는 경우
func third_Func(_ name : String) -> String {
    return "안녕하세요 \(name) 라고 해"
}

print(basic_Func(name : "Lkh")) // Lkh

print(another_Func(myName : "흑우")) // 흑우

print(third_Func("흑우이자 ios 전향하고 싶은 Lkh")) // 흑우이자 ios 전향하고 싶은 Lkh