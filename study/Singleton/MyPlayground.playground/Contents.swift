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
