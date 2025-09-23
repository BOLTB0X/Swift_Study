# 상속(Inheritance) VS 프로토콜(Protocol)

| 구분           | **프로토콜 (Protocol)**                    | **클래스 상속 (Inheritance)**                            |
| ------------ | -------------------------------------- | --------------------------------------------------- |
| **의미**       | "이 타입은 이런 기능을 제공한다"라는 **계약(Contract)** | "이 타입은 이 부모 클래스를 기반으로 만들어졌다"라는 **관계(Relationship)** |
| **다중 채택/상속** | 다중 채택 O (여러 프로토콜 동시에 채택 가능)            | 단일 상속만 O (Swift는 클래스 다중 상속 X)                       |
| **구현 여부**    | 구현은 전혀 없음 (메서드, 프로퍼티 시그니처만 정의)         | 부모의 구현을 그대로 상속받거나, 오버라이드로 재정의 가능                    |
| **적용 가능 대상** | 클래스, 구조체, 열거형 모두 가능                    | 오직 클래스만 가능                                          |
| **목적**       | **행동 규약** 을 정의 (타입이 특정 기능을 제공할 것을 보장)   | **코드 재사용 + 타입 계층 구조**                               |
| **확장**       | `Extension` 으로 기본 구현을 제공할 수 있음            | 기본 구현은 부모 클래스에 있음, 서브클래스에서 확장 어려움                   |
| **메모리 관리**   | 값 타입(`Struct`, `Enum`)도 채택 가능 -> 복사 기반      | 참조 타입(`Class`)만 상속 가능 -> `ARC` 기반                        |


둘 다 코드 재사용과 일관성 유지를 위해 쓰임

*"이 타입은 어떤 기능을 제공해야 한다"* 라는 계약적 의미를 포함할 수 있음

실제 프로젝트에서는 상속 + 프로토콜을 섞어 쓰는 경우가 많음 (ex. `UIViewController` + `UITableViewDelegate`)

---

## 상속(Inheritance) — 코드 ex) [InputManager](https://github.com/BOLTB0X/WOD-Timer-app/blob/main/WOD/Timer/Common/Controller/InputManager.swift) -> [SimpleViewModel](https://github.com/BOLTB0X/WOD-Timer-app/blob/main/WOD/Timer/Simple/SimpleRoot/ViewModel/SimpleViewModel.swift)

공통 로직(`InputManager`) 을 정의하고,

`SimpleViewModel` 에서 특화된 로직(타이머 상태, UI 관련 바인딩 등) 을 추가하는 구조

```swift
class InputManager: ObservableObject {
    @Published var selectedRoundAmount = 3
    @Published var selectedMovementAmount = MovementTime(hours: 0, minutes: 0, seconds: 30)
    // ...  
}

class SimpleViewModel: InputManager {
    static let shared = SimpleViewModel() // 싱글톤
    @Published var simpleDisplay: Int = 0
    @Published var simpleTimerState: TimerState = .cancelled {
        didSet { 
            /* InputManager 기능 활용 + 확장 */ 
        }
    }
}

```

- **구현 재사용** : `SimpleViewModel`은 `InputManager`의 모든 프로퍼티와 메서드를 그대로 사용 가능

- **타입 관계** : `SimpleViewModel` is-a `InputManager` (상속 관계가 곧 **"is-a"** 관계를 만듦)

- **제한** : Swift는 단일 상속만 가능 -> 여러 부모 클래스에서 동시에 물려받을 수 없음

- **클래스 전용** : 상속은 오직 `class` 에서만 가능 (`struct`, `enum` 불가)

- **확장성 문제** : 한 클래스가 너무 많은 기능을 상속받으면 **거대한 God Object** 가 될 위험 있음

---

## 프로토콜(Protocol) — 코드 ex) [APIBuilderProtocol](https://github.com/BOLTB0X/iOS-Dev_Study/blob/main/iOS-API/iOS-API/Data/API/APIBuilder.swift) + [APIServiceProtocol](https://github.com/BOLTB0X/iOS-Dev_Study/blob/main/iOS-API/iOS-API/Data/API/APIService.swift)

여기서는 `APIServiceProtocol`이 행동 규약(데이터를 요청하는 기능) 을 정의하고

`APIService`는 실제 네트워크 통신을 수행하는 구현체로 쓰임

```swift
protocol APIBuilderProtocol {
    associatedtype Response: Decodable
    var endpoint: Endpoint<Response> { get }
    func request(baseURL: URL, session: URLSession) async throws -> Response
    func decode(data: Data) throws -> Response
}

protocol APIServiceProtocol {
    func request<T: Decodable>(endpoint: Endpoint<T>, baseURL: URL, session: URLSession) async throws -> T
    func fetchImages() async throws -> [ImageDTO]
    func updateImageName(id: String, newName: String) async throws -> MessageDTO
}

final class APIService: APIServiceProtocol {
    private let baseURL: URL
    private let session: URLSession
    // APIServiceProtocol의 요구사항을 구현
}

```

- **구현 강제** : 프로토콜을 채택하면 반드시 그 안의 요구사항을 구현해야 함 (`fetchImages`, `updateImageName` 등)

- **다중 채택 가능** : `APIService`가 필요하다면 `APIServiceProtocol` 외에도 여러 프로토콜을 동시에 채택 가능

- **유연성** : 클래스, 구조체, 열거형 모두 채택 가능 (ex. `struct MockAPIService: APIServiceProtocol { ... }`)

- **의존성 역전** : 코드가 **"구체 타입(APIService)"** 가 아니라 **"프로토콜(APIServiceProtocol)"** 에 의존 -> 테스트/확장 용이

- **구현 공유** : `extension`을 통해 기본 구현 제공 가능 (여기서는 `request` 메서드)

---

## 정리

- 상속(Inheritance) : "코드 재사용 + is-a 관계"가 필요할 경우 

- 프로토콜(Protocol) : "행동 규약 + 다형성 + 유연성"이 필요할 경우

## 참고

- ~~내 코드들~~

- [블로그 참고 - Protocol 이해하기 (1/6) - Protocol이 도대체 뭔가요?(개발자소들이)](https://babbab2.tistory.com/174)

- [gitBook 참고 - Protocol](https://bbiguduk.gitbook.io/swift/language-guide-1/protocols)

- [공식문서 - inheritance](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/inheritance/)

- [블로그 참조 - 개발자 소들이(상속1)](https://babbab2.tistory.com/125)

- [블로그 참조 - 개발자 소들이(상속2)](https://babbab2.tistory.com/126)