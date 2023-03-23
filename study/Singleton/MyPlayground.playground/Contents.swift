import UIKit
// 싱글톤 패턴
// 싱글턴 패턴이란, 특정 용도로 인스턴스를 하나만 생성하여 공용으로 사용하고 싶을 때 사용하는 디자인 유형
// 클래스의 인스턴스를 최초 생성될 때 딱 한번만 생성해서 전역에 두고, 그 이후로는 이 인스턴스만 접근 가능하게 하기 위한 방법

class _Apply {
    var fullname: String?
    var age: Int?
    var grade: Double?
}

// apply의 정보를 저장하는 클래스가 있고, A View에서는 name을, B View에서는 age를, C View에서는 grade를 입력받아 StudentInfo라는 클래스에 저장해야 하는 상황

//A View
let Aapp = _Apply()
Aapp.fullname = "lkh"
//B View
let Bapp = _Apply()
Bapp.age = 30
//C View
let Capp = _Apply()
Capp.grade = 3.6

// apply라는 하나의 인스턴스에 모든 정보를 저장하고 싶은경우 -> 싱글턴 패턴
// 위 코드처럼 ViewController마다 인스턴스를 계속 생성하거나 인스턴스를 필요할 때마다 참조로 넘겨주는 방법은 메모리의 낭비가 일어나거나 코드가 복잡해짐

// 즉 싱글톤 패턴을 사용하면 하나의 인스턴스에 어디 클래스에서든 접근이 가능

class ApplyInfo {
    // 전역으로 저장되는 형태를 사용하므로
    // static을 이용해 Instance를 저장할 프로퍼티를 하나 생성
    static let shared = ApplyInfo()
    
    var name: String?
    var age: Int?
    var grade: Double?
    
    // init 메서드를 private로 지정
    // 인스턴스를 자꾸 생성하는 것을 방지하기 위해 FM으로는 private로 쓴다 함
    private init() {
        
    }
    
}

//A View
let AapplyInst = ApplyInfo.shared
AapplyInst.name = "lkh"

//B View
let BapplyInst = ApplyInfo.shared
BapplyInst.age = 30

//C View
let applyInst = ApplyInfo.shared
applyInst.grade = 3.6

// 즉 이 클래스의 인스턴스는 최초로 생성될 때 한번만 전역으로 생성하여 그 이후로는 이 인스턴스만 접근 가능한 패턴이 싱글톤패턴

// 싱글톤의 장점
//- 한 번의 Instance만 생성하므로 메모리 낭비를 방지
//- Singleton Instance는 전역 Instance로 다른 클래스들과 자원 공유가 쉬움
//- DBCP(DataBase Connection Pool)처럼 공통된 객체를 여러개 생성해서 사용해야하는 상황에서 많이 사용 (쓰레드풀, 캐시, 대화상자, 사용자 설정, 레지스트리 설정, 로그 기록 객체등)

// 싱글톤의 단점
//Singleton Instance가 너무 많은 일을 하거나, 많은 데이터를 공유시킬 경우 다른 클래스의 Instance들 간 결합도가 높아져 "개방=폐쇄" 원칙을 위배함 (객체 지향 설계 원칙 어긋남)
//- 따라서 수정과 테스트가 어려워짐

// static을 사용해 타입 프로퍼티로 인스턴스를 생성하면, 사용 시점에 초기화(lazy)

// Singleton Instance가 최초 생성되기 전까진 메모리에 올라가지 않고, Dispatch_once도 자동 적용, 따라서 별 코드 없이도 Instance가 여러 개 생성되지 않는 Thread-Safe한 방법이 되는 것임

// 위에서 Swift가 Thread-Safe하다고 한 것은 "싱글톤 생성"에 한정해 Thread-Safe하단 것임
