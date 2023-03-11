# 상속: Inheritance

> “조상이 자손에게 유전적으로 뭔가 주는 것처럼”
> “ 객체들 간의 관계를 구축하는 방법”
> 이를 객체지향 버전으로 풀면 A 객체가 B 객체를 상속받아 B 객체의 요소(property)를 사용하는 것
> <br/>
> 즉 A 객체는 자식이고 B 객체 부모 라고 생각하면 됌
> <br/>

## cf. 자식 객체는 상속된 부모 객체의 은닉화되어진 구성에 따라 변수, 메소드에 접근 가능

## 기본 클래스

```
class Human {
var field: String?
var age: Int?
}
```

이렇게 Human 이란 이름 뒤에 아무런 클래스가 기본클래스
<br/>
이 클래스는 아무런 상속 받지 않음
<br/>

## cf. 뒤에 ‘Hashable’같은 프로토콜을 채택해도 base class에 속함

## 서브클래싱(Subclassing)

```
class Coder: Human { // class Human의 속한 프로퍼티들도 싹다 사용 가능
	var noteBook: String?
}

Let lkh: Coder = .init()
Lkh.field
Lkh.noteBook
```

기본 클래스를 기반으로 새로운 클래스를 만드는 것
<br/>
서브 클래스 이름 옆에 콜론(:)을 쓰고 가장 먼저 상속 받고자 하는 슈퍼 클래스의 이름 추가해주면 됌
<br/>
