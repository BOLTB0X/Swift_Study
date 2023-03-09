// 매개변수로서 클로저
func say(completion: () -> Void) {
    print("안녕하세요")
    sleep(3)

    // 클로저 실행
    completion()
}

say(completion: {
    print("3초가 지났다. 1")
})

// 이것도 가능
say() {
    print("3초가 지났다. 2")
}

// 요것도 가능
say {
    print("3초가 지났다. 1")
}

// 매개변수로서 데이터 반환
func say2(completion : (String) -> Void) {
    print("HI!!!!!!!!!")
    sleep(3)

    // 클로저를 실행과 동시에 데이터 반환
    completion("HOW ARE YOU")
}

say2(completion : { (comment : String) in
    print("3초 후 \(comment)")
})

// 이것도 가능
say2(completion : { comment in
    print("3초 후 또  \(comment)")
})

// 여것도 가능
say2{ comment in
    print("3초 후 또 다시 \(comment)")
}