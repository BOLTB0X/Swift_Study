## DTO(Data Transter Object)

- data 전송/교환을 위한 객체
- data를 Object로 변환하는 객체
- A.swift->B.swift, AView->BView처럼 전달하는 작업을 처리하는 Object
- method 호출 횟수를 줄이기 위해 데이터를 담고 전달하는 것, 가변성인 특징이 있음
- VO+set으로 볼 수있음
  즉, 계층간 data 교환을 위해 사용하는 객체(viewcontroller-ServiceDAO, swift에서는 JSON의 response를 Entity로 변환)
  주로 보안성 및 캡슐화, data 은닉의 목적으로 private으로 선언
  get, set

## VO(Value Object)

- 값을 위해 사용하는 Object
- 읽기를 하기 위해서 사용하는 객체
- 간단한 독립체를 의미하는 작은 객체를 의미
- 값이 같으면 동일한 Object라고 볼 수 있음
- 불변성
