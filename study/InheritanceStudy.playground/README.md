# 상속: Inheritance

> “조상이 자손에게 유전적으로 뭔가 주는 것처럼”
> <br/>
> “ 객체들 간의 관계를 구축하는 방법”
> <br/>

이를 객체지향 버전으로 풀면 A 객체가 B 객체를 상속받아 B 객체의 요소(property)를 사용하는 것
<br/>

즉 A 객체는 자식이고 B 객체 부모 라고 생각하면 됌
<br/>

cf. 자식 객체는 상속된 부모 객체의 은닉화되어진 구성에 따라 변수, 메소드에 접근 가능

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
cf. 뒤에 ‘Hashable’같은 프로토콜을 채택해도 base class에 속함

## 서브클래싱(Subclassing)

```
class Coder: Human { // class Human의 속한 프로퍼티들도 싹다 사용 가능
	var noteBook: String?
}

let lkh: Coder = .init()
Lkh.field
Lkh.noteBook
```

기본 클래스를 기반으로 새로운 클래스를 만드는 것
<br/>
서브 클래스 이름 옆에 콜론(:)을 쓰고 가장 먼저 상속 받고자 하는 슈퍼 클래스의 이름 추가해주면 됌
<br/>
즉 저 상위 클래스인 Human = Super class, human을 상속받는 lkh 클래스를 sub class
<br/>
lkh 클래스는 human이란 클래스에 상속받고, 이를 서브클래싱이라 함
<br/>
Cf) 메소드도 상속 가능~

---

## final: 상속을 금지

```
final class Human {
    var field: String?
    var age: Int?
}
```

# 오버라이딩(Overriding): 재정의

> 상속할 인스턴스 메서드, 타입 메서드, 인스턴스 프로퍼티, 타입 프로포티, 서브스크립트을 상속할 것 기반으로 구현 및 수정하는 것이 Overriding

```
class Coder: Human {
	override func description() {
		print(“iOS입니다”)
	}
}
```

Coder란 클래스는 Human 슈퍼클래스의 description 메소드를 오버라이딩(재정의)
<br/>
여기서 coder 인스턴스를 만들고 coder의 description을 실행하면 오버라이딩한게 됌
<br/>
Cf. 만약 슈퍼클래스의 메소드를 이용하고 싶으면?

```
class Coder: Human {
	override func description() {
		print(“iOS입니다”)
	}
	super.description() // super의 메소드 명시해줌
}
```

## propery Overriding

### 저장

서브 클래스에서는 상속된 프로퍼티의 특성이 저장 property인지, 연산 property 인지 구분이 불가능
<br/>
그냥 상속받은 property의 이름과 타입정도
<br/>
cf. 변경 가능한 프로퍼티를 read-only 프로퍼티로 오버라이딩 할 수 없음
<br/>
이미 super class에서 문자열 변수 같은 프로퍼티는 “저장 프로퍼티”여서 기본적으로 getter / setter가 모두 제공되는 Read&Wirte가 가능한 프로퍼티
<br/>
즉 read만 할려거나 write만 Overriding을 하면 에러 발생
<br/>

> 저장 프로퍼티 예시

```
class Coder: Human {
    var filed = “iOS"

    override var name: String {
        get {
            return self.filed
        }
        set {
            self.field = newValue
        }
    }
}
```

### 연산

위와 마찬가지로 getter/setter 구현
<br/>

```
class Human {
    var name = "lkh"

    var nick: String {
        return self.name + " B0X"
    }
}

class coder: Human {
    override var feild: String {
        return self.name + " iOS”
    }
}

class anotherCoder: Human {
    override var feild: String {
        get {
            return self.name + " android"
        }
        set {
            self.name = newValue
        }
    }
}

```

cf.만약 이런형태로 superclass가 선언 되어있다면

```
class Human {
    var name = "3kh"

    var alias: String {
        get {
            return self.name + " B0X"
        }
        set {
            self.name = newValue
        }
    }
}
// Human이란 클래스에 alias라는 연산 프로퍼티가 getter / setter로 구현된 경우

class Coder: Human {
    override var alias: String {  // 해당 프로퍼티 오버라이딩 불가능
       return self.name + " !?"
    }
}
```

## 프로퍼티 옵저버

저장 프로퍼티의 경우, var로 선언된 프로퍼티만 오버라이딩으로 옵저버를 추가 가능
<br/>
연산 프로퍼티의 경우, getter / setter가 모두 구현된 경우만 오버라이딩으로 옵저버를 추가가능
<br/>

### 저장 프로퍼티

```
class Human {
    var name = "lkh"
}

class dev: Human {
    override var name: String {
        willSet {
            print("이름 변경 \(newValue)")
        }
        didSet {
            print("이름 변경 \(oldValue)")
        }
    }
}
```

슈퍼 클래스의 name이란 "변수 저장 프로퍼티"를 dev란 서브 클래스에서 오버라이딩 하여 프로퍼티 옵저버를 추가 가능
<br/>
cf. 반드시 프로퍼티의 이름과 타입이 반드시 명시해줘야함
<br/>

### 연산 프로퍼티

getter / setter가 모두 구현된 연산 프로퍼티만 프로퍼티 옵저버를 추가 가능
<br/>
getter / setter 가 모두 붙어있는 프로퍼티만 오버라이딩해서 프로퍼티 옵저버를 추가 가능
<br/>

```
class Human {
    var name = "lkh"

    var alias: String {
        get {
            return name + " B0X"
        }
        set {
            self.name = newValue
        }
    }
}

class dev: Human {
    override var alias: String {
        willSet {
            print("연산 프로퍼티 set 예정")
        }
        didSet {
            print("연산 프로퍼티 set이 실행 됌")
        }
    }
}
```

### Final 오버라이딩

오버라이딩이 가능한 프로퍼티, 메서드, 서브스크립트 등에 final을 붙이면, 해당 정의는 더이상 "오버라이딩이 불가
<br/>
