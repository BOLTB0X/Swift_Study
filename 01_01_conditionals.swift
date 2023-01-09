var isDarkModeOn : Bool = true

//조건문
if (isDarkModeOn == true) {
	print("다크모드 입니다.")
}

if (isDarkModeOn != true) {
	print("다크모드가 아닙니다.")
}

// 괄호생략 가능
if isDarkModeOn == true {
	print("다크모드 입니다.")
}

if isDarkModeOn {
	print("다크모드 입니다.")
}

if !isDarkModeOn {
	print("다크모드 입니다.")
}