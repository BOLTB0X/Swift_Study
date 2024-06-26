# LifeCycle

> 어떤 시스템, 객체 또는 프로세스가 생성되고 시작되어 활성화되고 사용된 후 종료되는 과정

## App Life Cycle

App의 실행 / 종료 및 App이 Foreground / Background 상태에 있을 때, 시스템이 발생시키는 event에 의해 App의 상태가 전환되는 일련의 과정

App의 현재 상태에 따라 할 수 있는 것과 할 수 없는 것이 결정됌
<br/>

<img src="https://docs-assets.developer.apple.com/published/8e113a7266/scene-state~dark@2x.png" width="300" height="300"/>

Scene 전환을 사용하여 다음 작업을 수행

- UIKit이 장면을 앱에 연결하면 장면의 초기 UI를 구성하고 장면에 필요한 데이터를 로드
  <br/>

- foreground-active state 로 전환할 때 UI를 구성하고 사용자와 상호 작용할 준비
  <br/>

- foreground에서 실행할 UI 준비를 참조
  <br/>

- 활성 상태를 벗어나면 데이터를 저장
  <br/>

- background 상태에 들어가면 중요한 작업을 완료하고 가능한 한 많은 메모리를 확보하고 앱 스냅샷을 준비
  <br/>

- scene 연결 해제 시 장면과 연결된 모든 공유 리소스를 정리
  <br/>

- 장면 관련 이벤트 외에도 UIApplicationDelegate 개체를 사용하여 앱 실행에 응답해야 함
  <br/>

예를 들어 Foreground App은 사용자의 주의를 끌기 때문에 CPU를 포함한 시스템 리소스보다 우선순위가 높음

반대로 Background App은 offscreen이기 때문에 가능한 적은 작업을 수행해야하고, 되도록 아무것도 수행 X

또한 앱의 상태가 변경될 때 마다 그에 맞는 동작을 조정이 필요

## App State

- Not Running
  App이 아직 실행되지 않았거나, 완전히 종료되어 동작하지 않는 상태
  <br/>

- Foreground -Inactive

  - App이 실행중이지만 사용자로부터 event를 받을 수 없는 상태
    <br/>
  - multitasking window로 진입하거나 App 실행중 전화, 알림 등에 의해 App 사용할 수 없게 되는 경우 이 상태로 진입
    <br/>

- Foreground -Active

  - Active는 app이 실제 실행중이고 사용자 event를 받아서 상호작용할 수 있는 상태
    <br/>
  - 바로 Active가 되지 않고 Inactive 상태를 거쳐 Active상태가 됨
    <br/>

- Backgound -Running

  - 홈화면으로 나가거나 다른 App으로 전환되어 현재 App이 실질적인 동작을 하지 않는 상태
    <br/>
  - 예를 들어 Music App을 닫아도 재생한 음악이 계속 실행되는 경우
    <br/>
  - 사용자가 App을 사용하지 않는 동안 서버와 데이터를 동기화하거나 타이머가 실행되어야 하는 등의 작업을 이 상태에서 할 수 있음
    <br/>

- Backgound - Suspended

  - App을 다시 실행했을 때 최근 작업을 빠르게 로드하기 위해 메모리에 관련 데이터만 저장 되어있는 상태
    <br/>

  - App이 background 상태에 진입했을 때 다른 작업을 하지 않으면 Suspended 상태로 진입(보통 2~3초 이내)
    <br/>

  - Suspended 상태의 App들은 iOS의 메모리가 부족해지면 가장 먼저 메모리에서 해제
    <br/>

  - 따라서 App을 종료시킨 적이 없더라도 app을 다시 실행하려고 하면 처음부터 다시 실행

## 참고

[공식문서 - Life cycle](https://developer.apple.com/documentation/uikit/app_and_environment/managing_your_app_s_life_cycle)

[블로그 참조](https://velog.io/@delmasong/Managing-Your-Apps-Life-Cycle)
