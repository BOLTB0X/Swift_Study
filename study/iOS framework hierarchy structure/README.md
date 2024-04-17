# iOS framework hierarchy structure

> iOS App 개발하는 데 필요한 여러 가지 기능과 resources를 제공하는 소프트웨어 라이브러리 모음

iOS 프레임워크는 다양한 계층으로 구성되어 있으며, 각 계층은 특정한 기능을 담당

> 변수, 상수, 함수 -> 클래스 -> 프레임워크 -> OS

## Framework

> 어떠한 목적을 달성하기 위해 복잡하게 얽혀있는 문제를 해결하기 위한 구조로, 소프트웨어 개발에 있어 하나의 뼈대 역할

프레임워크는 동적 공유 라이브러리, nib 파일, 이미지 파일, localized 문자열, header file 및 참조 문서와 같은 공유 resources를 단일 package에 캡슐화하는 계층적 directory

> 원하는 기능을 사용하고 싶다면 해당 기능을 제공하는 프레임워크를 import 하여 사용

OS는 iOS, mac 등의 내부의 HW가 일관되게 동작할 수 있는 이유 -> 구조화된 프레임워크 4 계층(**Cocoa / Cocoa Touch** , **Media** , **Core Service** , **Core OS** )

![프레임워크 계층 구조](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FuQS8r%2FbtqNf6Mb2JD%2FR3NfHijcN5Lf608eVlRbF1%2Fimg.png)

상위 계층으로 갈수록 Application과 가까운 사용자 구현 기능이 담겨있음

## Cocoa / Cocoa Touch

> Cocoa라는 단어가 붙으면 우선 Objective-C Runtime을 기반으로 NSObject를 상속 받는 모든 클래스, 모든 객체를 가리킬 때 사용

![Cocoa / Cocoa Touch](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FLEC2Y%2FbtqM9PefOH8%2FQfpQDKmluZHQkj7NFUQu0K%2Fimg.png)

- **Cocoa**
  macOS 개발을 위한 프레임워크
  <br/>

- **Cocoa Touch**
  iOS 및 tvOS Application 개발을 위한 프레임워크
  <br/>

최상위 레벨 프레임워크로 Foundation이나 CoreData를 불러와서 사용

UI를 구축하고 관리하기 위한 UIKit, 이벤트 처리를 위한 EventKit, 터치 입력을 처리하기 위한 TouchKit 등의 서브 프레임워크를 포함

> - UIKit : 사용자에 의해 발생하는 이벤트 처리 기능, UI와 관련된 기능
> - Foundation : String, Date, runLoop, GCD, Thread, URL 작업등을 처리
> - AddressBookUI: 주소록 관련 기능
> - GameKit : 게임 관련 기능
> - MapKit : 지도 관련 기능
> - NotificationCenter: 노티피케이션 관련 기능
> - ...

## Media

> 오디오, 비디오, 이미지 및 그래픽 처리와 관련된 기능을 제공

![Media](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FoctZw%2FbtqNbuHuL2S%2FljNhjHTwpowWe6DK7KhRK1%2Fimg.png)

- C 와 Objectice-C가 혼합
  <br/>

- Core Audio, Core Video, Core Image 및 Metal과 같은 서브 프레임워크를 포함

> - Photos : 사진 관련 기능
> - CoreGraphics: 2D 화면 그리기 관련 기능
> - AssetsLibrary: 앨범 관련 기능
> - AVFoundation : 영상 관련 기능
> - ...

## Core Services

> iOS의 핵심 기능을 제공하는 프레임워크

![Core Services](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbcJCEa%2FbtqNbvzFNSN%2FVAiHcJAn5q51VyIdGDvPB0%2Fimg.png)

- UI와 직접적인 관계 X
  <br/>
- 사용자 설정, 네트워킹, String 처리, 데이터 집합, 주소록, 환경설정 등, 데이터 관리 및 Application 생명주기 관리와 같은 기능을 포함
  <br/>
- GPS, 가속도 센서 등 디바이스 하드웨어 특성에 기반한 서비스도 제공
  <br/>

- Foundation, Core Data, Core Location, Core Motion 및 iCloud와 같은 서브 프레임워크가 여기에 포함

> - Webkit : HTML 관련 처리 기능
> - CloudKit : iCloud 연동 처리 기능
> - CoreLocation : 위치, 방향 데이터 처리 기능
> - StoreKit : In-App Purchase 구현 기능
> - XML Parsing, Keychain, Notification Center, StoreKit, Security, GCD 등
> - ...

## Core OS

> 하드웨어 관리 및 저수준(low level) 시스템 서비스를 제공

![Core OS](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2F7tQ2K%2FbtqM9pUvoyj%2FbbH6i5WldwHkz2MMe0TcjK%2Fimg.png)

- HW와 가장 가까이 있는 최하위 계층
  <br/>

- 커널, 파일 시스템, 네트워크, 보안, 전원관리, 환경설정 등의 기능
  <br/>

- iOS가 운영체제로서 역할을 하게 함

> - CoreBluetooth : 블루투스 연결 관련 처리
> - LocalAuthentication : TouchID, 사용자 인증 관련 처리
> - Security : 키체인 및 인증서 관련 보안 처리
> - ...

## 참고

[블로그 참고 - 1](https://nsios.tistory.com/82)

[블로그 참고 - 2](https://velog.io/@justdotheg/Swift-%EA%B8%B0%EC%B4%88-%ED%94%84%EB%A0%88%EC%9E%84%EC%9B%8C%ED%81%AC%EB%9E%80)

[블로그 참고 - 3](https://infinitt.tistory.com/356)
