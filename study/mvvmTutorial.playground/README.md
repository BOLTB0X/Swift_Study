# MVVM

## MVVM이란?

MVVM(Model-View-ViewModel)은 개체를 세 개의 개별 그룹으로 구분하는 구조적 디자인 패턴
<br/>

## Model

Models은 application data 를 보유 및 관리(hold)
<br/>
그냥 일반적으로 구조체(struct), 클래스(class)
<br/>

ex)

```swift
public class Pet {
    public enum Rarity {
        case common
        case uncommon
        case rare
        case veryRare
    }

    public let name: String
    public let birthday: Date
    public let rarity: Rarity
    public let image: UIImage

    public init(name: String,
                birthday: Date,
                rarity: Rarity,
                image:UIImage) {
        self.name = name
        self.birthday = birthday
        self.rarity = rarity
        self.image = image
    }
}
```

## Views

view는 말 그대로 나타내는 구조, 시각적 요소와 컨트롤을 화면에 표시
<br/>
일반적으로 UIView의 하위 클래스
<br/>

## ViewModels

Model data를 View에 나타내는 값으로 변환
<br/>
일반적으로 클래스이므로 주로 참조로 전달
<br/>

ex)

```swift
public class PetViewModel {
    // 2개의 private 프로퍼티를 생성, init
    private let pet: Pet
    private let calendar: Calendar

    public init(pet: Pet) {
        self.pet = pet
        self.calendar = Calendaår(identifier: .gregorian)
    }

    // cf.
    // computed propertie: 다른 속성을 기반으로 속성 값이 결정
    // Stored Property은 값을 저장할 메모리 공간 O
    // Computed Property는 메모리 공간 X

    // 연산 프로퍼티 2개 선언
    // 만약 개발도중 모든 애완 동물의 이름에 접두사를 추가하도록 디자인을 변경하려는 경우 여기에서 이름을 수정하여 쉽게 변경 가능
    public var name: String {
        return pet.name
    }

    public var image: UIImage {
        return pet.image
    }

    // 약간 다른 연산 프로퍼티 선언
    // 여기에서 Calendar를 이용하여 오늘 시작일과 애완동물의 생일 사이의 연도 차이를 계산하고 "연령"이 뒤에 오는 문자열로 반환하는 프로퍼티를 선언해줌
    // 다른 문자열 형식을 수행하지 않고도 이 값을 뷰에 직접 표시 가능
    public var ageText: String {
        let today = calendar.startOfDay(for: Date())
        let birthday = calendar.startOfDay(for: pet.birthday)
        let components = calendar.dateComponents([.year], from: birthday, to: today)

        let age = components.year!
        return "\(age) years old"
    }

    // 희귀도에 따라 애완 동물의 입양 비용을 결정하는 연산 프로퍼티
    // 이것을 직접 표시할 수 있도록 문자열로 반환
    public var adoptionFeeText: String {
        switch pet.rarity {
            case .common:
                return "$50.00"
            case .uncommon:
                return "$75.00"
            case .rare:
                return "$150.00"
            case .veryRare:
                return "$500.00"
        }
    }
}
```

## MVC와 MVVM의 차이

일반적으로 MVC 패턴과 매우 유사하면서도 다름, MVVM에서 VM이 뷰 컨트롤러가 포함되어져있음
<br/>
즉 MVVM 패턴에 존재는 하지만 뷰 컨트롤러의 역할이 최소화되어있다 생각하면 됌
<br/>

## 그럼 MVVM을 왜 쓸까?

<em> MVVM 패턴은 MVC 패턴에서 ViewController의 큰 역할로 인해 규모가 커지는 것을 보완이 가능 함
<br/>

ViewModel이 없는 MVC 패턴에서 View 컨트롤러에 Model에서 view로 변환 코드를 넣어줄 것임 하지만 viewDidLoad 및 기타 뷰 수명 주기 이벤트 처리, IBActions 및 기타 여러 작업을 통해 뷰 콜백 처리 등 이미 다양한 역할을 하고 있으므로 너무 ViewController에 역할이 너무 비대해지는 것
<br/>

그러므로 MVVM 패턴을 이용하면 Model간의 변환이 VM이 담당하게 됌
<br/>

모델을 뷰에 대한 다른 표현으로 변환해야 하는 경우 이 패턴을 사용
<br/>

> ex) 뷰 모델을 사용하여 날짜를 날짜 형식의 문자열로 변환
> 십진수를 통화 형식의 문자열로 변환

---

## 참고 주소

> https://www.kodeco.com/34-design-patterns-by-tutorials-mvvm
