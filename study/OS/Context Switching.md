# Context Switching

> CPU(or 코어) 에서 실행 중이던 프로세스나 스레드가 다른 프로세스나 스레드로 교체되는 것

- **Context** : 프로세스의 실행 상태 (레지스터, PC, 스택 포인터 등)

- **Switching** : 한 프로세스의 Context를 저장하고, 다른 프로세스의 Context를 복원하는 행위

여러 프로세스가 **“동시에”** 실행되는 것처럼 보이도록 하기 위해 운영체제가 수행하는 핵심 기능

---

## 정의

컴퓨터가 현재 실행 중인 **프로세스/스레드의 상태(Context)** 를 저장하고,

다른 프로세스/스레드의 저장된 상태를 불러와 실행을 이어가는 과정을 말함

```
[현재 실행 중]  -> (Context Capture / Save) -> [다음 실행할 프로세스 Restore / Load]
```

OS 스케줄러에 의해 CPU 사용 시간을 다 쓴 프로세스가 다른 프로세스로 전환되거나,

*HW* 나 *시스템 콜* 같은 외부 신호에 의한 **인터럽트** 가 발생하여 현재 작업을 중단하고 다른 작업을 처리하기 위해 컨텍스트 스위칭이 일어남

### 주요 트리거

#### 1. 인터럽트

<p align="center">
   <img src="https://github.com/BOLTB0X/Swift_Study/blob/main/study/OS/%EC%9D%B8%ED%84%B0%EB%9F%BD%ED%8A%B8.png?raw=true" alt="Example Image" width="90%">
</p>

인터럽트는 HW 또는 SW에 의해 발생하며, CPU에게 현재 작업을 중단하고 특정 이벤트를 처리하도록 요청

- **하드웨어 인터럽트** : 키보드 입력, 마우스 움직임, 디스크 입출력 완료 등과 같은 하드웨어 장치에서 발생하는 이벤트가 이에 해당

- **SW 인터럽트 (시스템 호출)** : 실행 중인 프로세스가 운영체제의 커널 기능을 요청할 때 발생, *ex 파일을 읽거나 쓰거나, 새로운 프로세스를 생성하는 경우*

#### 2. 멀티태스킹 (시분할 시스템)

<p align="center">
   <img src="https://github.com/BOLTB0X/Swift_Study/blob/main/study/OS/%EC%9D%B8%EA%B0%84%EC%9E%85%EC%9E%A5%EB%A9%80%ED%8B%B0%ED%85%8C%EC%8A%A4%ED%82%B9.png?raw=true" alt="Example Image" width="50%"> <br/> 인간 입장 <br/>
   <img src="https://github.com/BOLTB0X/Swift_Study/blob/main/study/OS/%EC%BB%B4%ED%93%A8%ED%84%B0%EC%9E%85%EC%9E%A5%EB%A9%80%ED%8B%B0%ED%85%8C%EC%8A%A4%ED%82%B9.png?raw=true" alt="Example Image" width="50%"> <br/> 실제 컴퓨터 처리
</p>

하나의 CPU가 여러 프로세스에 CPU 시간을 공정하게 분배하기 위해 발생

- **타임 슬라이스 만료** : 각 프로세스에 할당된 짧은 시간(타임 슬라이스)이 끝나면, OS 스케줄러가 다음 프로세스로 전환하기 위해 컨텍스트 스위칭을 발생시킴

#### 3. 입출력 (I/O) 요청

프로세스가 디스크에서 파일을 읽거나, 네트워크 데이터를 기다리는 등 느린 입출력 작업을 요청할 때 발생

- **자발적 전환** : 입출력 작업이 완료될 때까지 CPU를 점유할 필요가 없으므로, 프로세스는 자발적으로 CPU를 양보하는데, 이로 인해 CPU는 대기 상태에 있는 다른 프로세스를 실행할 수 있게 됌

- **입출력 완료 알림** : 입출력 작업이 완료되면, 하드웨어 인터럽트가 발생하여 운영체제에 알리고, 대기 중이던 원래 프로세스로 다시 전환될 수 있음

#### 4. 높은 우선순위 프로세스의 출현

- 더 높은 우선순위를 가진 프로세스가 실행 준비 상태가 되면, 운영체제는 현재 실행 중인 프로세스를 선점하고 새로운 프로세스를 실행하기 위해 컨텍스트 스위칭을 일으킴

#### 5. 프로세스 종료

- 현재 실행 중인 프로세스가 작업을 완료하거나 어떤 이유로든 종료되면,

- OS는 해당 프로세스에 할당된 자원을 회수하고 다음 프로세스를 실행하기 위해 컨텍스트 스위칭을 발생시킴

#### 6. 사용자/커널 모드 전환

OS가 시스템 리소스에 접근하는 등 특권이 필요한 작업을 수행하기 위해 사용자 모드에서 커널 모드로 전환할 때 컨텍스트 스위칭이 일어날 수 있음

---

## PCB (Process Control Block)

> OS가 프로세스를 관리하기 위해 유지하는 핵심 자료구조(메타데이터 집합)

> 프로세스의 상태를 저장해 두었다가 다시 실행을 재개할 수 있도록 해주는 역할

<p align="center">
   <img src="https://github.com/BOLTB0X/Swift_Study/blob/main/study/OS/PCB.png?raw=true" alt="Example Image" width="70%">
</p>


- PCB는 프로세스의 모든 실행 정보를 보관하는 운영체제 내부 데이터 구조이며,
컨텍스트 스위칭의 핵심 기반

- ex. *프로세스의 주민등록증 + 현재 실행 상태 기록부*

| 구분            | 저장되는 정보 ex                       |
| --------------- | -------------------------------- |
| CPU Context | 레지스터 값, 프로그램 카운터(PC), 스택 포인터(SP) |
| 프로세스 관리 정보      | PID, 부모/자식 프로세스 정보, 우선순위, 스케줄러 큐 |
| 메모리 관리 정보       | 페이지 테이블 주소, 메모리 보호 정보            |
| 파일/자원 정보        | 열린 파일 목록, 입출력 장치 정보              |
| 권한 정보           | 사용자/권한 정보, 접근 제어                 |

**이전 프로세스 컨텍스트 저장 + 다음 프로세스 컨텍스트 복원**

- *cf. PCB가 없다면 CPU는 “내가 어디까지 했더라?” 하고 다시 작업을 처음부터 함*

- *cf. PCB는 커널 메모리에 저장 됌*

## 동작 과정

**커널 모드에서 진행**

> 프로세스가 실행이 되다가 하드웨어랑 밀접한 일들, 혹은 여러 리소스들을 다뤄야하는 상황이 있다.<br/>
>이럴때는 프로세스가 직접 리소스에 접근하는 것이 아니라 운영체제를 통해 접근하게 되는데, 특이 커널을 통해서 접근하게 된다.<br/>
> 이떄 통제권이 프로세스->커널로 넘어간다.
이때 커널에 의해서 실행되는 것을 커널모드라고 한다.<br/>
> [블로그 글 참고](https://velog.io/@kimunche/%EC%BB%A8%ED%85%8D%EC%8A%A4%ED%8A%B8-%EC%8A%A4%EC%9C%84%EC%B9%ADcontext-switching)

<p align="center">
   <img src="https://github.com/BOLTB0X/Swift_Study/blob/main/study/OS/ContextSwitching1.png?raw=true" alt="Example Image" width="80%">
    <img src="https://github.com/BOLTB0X/Swift_Study/blob/main/study/OS/ContextSwitching2.png?raw=true" alt="Example Image" width="80%">
</p>


> 1 현재 프로세스의 레지스터, 프로그램 카운터, 스택 포인터 등을 PCB에 저장<br/>
> 2 스케줄러가 다음 실행할 프로세스를 선택<br/>
> 3 선택된 프로세스의 PCB에서 저장된 Context 복원<br/>
> 4 CPU가 새 프로세스를 실행 (실행 재개)

### 1. **저장(Capture / Save)**

- 현재 실행 중인 *프로세스 A* 가 CPU를 반납해야 할 때,
    
- OS는 *프로세스 A* 의 **현재 상태(Context)** 를 **프로세스 제어 블록(Process Control Block, PCB)** 에 저장함


### 2. **저장되는 주요 정보**

- **프로그램 카운터 (PC)** : 다음에 실행할 명령어의 주소

- **레지스터 값** : CPU 내부에 있는 임시 저장 공간(레지스터)의 모든 값

- **스택 포인터** : 프로세스 스택의 현재 위치

- **CPU 상태 정보** : 인터럽트 상태, 실행 모드 등


### 3. 전환 (Switch)

- OS는 스케줄링 알고리즘에 따라 다음에 실행할 *프로세스 B* 를 선택


### 4. 복원 (Restore / Load)

- OS는 *프로세스 B* 의 PCB에 저장되어 있던 모든 Context 정보를 CPU의 레지스터와 프로그램 카운터 등으로 복원
    
- *프로세스 B* 는 저장된 시점부터 실행을 재개

---



## 쓰이는 이유

- CPU가 여러 작업을 동시에 처리하는 것처럼 보이게 하는 기술

    - 실제로는 아주 빠른 속도로 전환하는 것일 뿐

- 멀티태스킹 환경 구현에 필수 

    - *ex: 여러 앱을 동시에 켜놓고 작업할 때*

## 컨텍스트 스위칭의 비용

컨텍스트 스위칭은 여러 작업을 동시에 처리하기 위한 필수적인 과정이지만,

프로세스의 상태를 저장하고 복원하는 데 CPU 오버헤드가 발생할 수 있는데,

이 오버헤드가 너무 자주 발생하면 시스템 성능이 저하될 수 있음

---

## 멀티태스킹과 컨텍스트 스위칭

<p align="center">
   <img src="https://github.com/BOLTB0X/Swift_Study/blob/main/study/OS/%EB%A9%80%ED%8B%B0%ED%85%8C%EC%8A%A4%ED%82%B9%EA%B3%BC%EC%BB%A8%ED%85%8D%EC%8A%A4%ED%8A%B8%EC%8A%A4%EC%9C%84%EC%B9%AD.png?raw=true" alt="Example Image" width="70%">
</p>

**멀티태스킹** : *"무엇을 하는가"* 에 대한 개념

**컨텍스트 스위칭** : *"어떻게 하는가"* 에 대한 개념


### 멀티태스킹(Multitasking)

OS가 여러 작업을 동시에(엄밀히 말하면 매우 짧은 시간 동안 번갈아가며) 처리하는 것처럼 보이게 하는 기능을 의미

#### 목적

- CPU 하나로 여러 프로그램(프로세스)을 동시에 실행하는 것처럼 보이게 하여 시스템의 효율성을 올림

#### 작동 방식

- CPU 시간을 여러 프로세스에 조금씩 나누어 할당함

- 각 프로세스는 할당받은 시간(타임 슬라이스) 동안 실행되며, 시간이 끝나면 다음 프로세스로 교체

- *ex. 웹 브라우저로 인터넷 서핑을 하면서 동시에 음악을 듣고, 문서 편집기를 사용하는 상황이 멀티태스킹의 대표적인 예시*

---

## 스레드 Context Switching

>  스레드도 컨텍스트 스위칭이 발생하지만, 프로세스 컨텍스트 스위칭과는 차이가 있으며 훨씬 가볍고 빠름

*cf. 스레드는 프로세스 내에서 실행의 단위*

여러 스레드가 동시에 실행되는 것처럼 보이려면, CPU가 한 스레드에서 다른 스레드로 실행을 전환해야 함

- 이 과정에서 각 스레드 고유의 정보(스택, 레지스터 등)를 저장하고 복원하는 **컨텍스트 스위칭** 이 필수적

- 스레드도 컨텍스트 스위칭을 수행하지만, **공유하는 리소스** 가 많기 때문에,

- 프로세스 간 전환보다 훨씬 적은 오버헤드로 빠르게 처리

*cf. 이것이 멀티스레딩이 멀티프로세싱보다 효율적일 수 있는 주요 이유 중 하나이기도 함*

### 스레드 컨텍스트 스위칭과 프로세스 컨텍스트 스위칭의 차이

| **특징** | **스레드 컨텍스트 스위칭** | **프로세스 컨텍스트 스위칭** |
|:--|:--|:--|
| **대상** | 같은 프로세스 내의 다른 스레드 간 전환 | 완전히 다른 프로세스 간 전환 |
| **공유 영역** | 코드, 데이터, 힙 영역을 공유 | 모든 메모리 공간과 자원이 독립적 |
| **전환 시 저장/복원** | 각 스레드만의 독립적인 스택, 프로그램 카운터(PC), 레지스터만 저장하고 복원 | 전체 프로세스의 상태(메모리 주소 공간, 파일 핸들 등)를 저장하고 복원 |
| **캐시 영향** | 캐시 메모리를 비울 필요가 없어 캐시 효율이 높음 | 캐시 메모리의 데이터가 무효화될 수 있어 캐시 효율이 떨어짐 |
| **비용 및 속도** | 프로세스 전환에 비해 훨씬 가볍고 빠름 | 더 많은 자원을 저장하고 복원해야 하므로 무겁고 느림 |


---

## 참고

- [유튜브 (10분 테코톡) - 코맥의 Interrupt와 Context Switching](https://www.youtube.com/watch?v=-4HKhwlH3FQ)

- [유튜브 (널널한 개발자 TV) - Chapter03 프로세스 상태(휴식, 보류)와 문맥 교환](https://www.youtube.com/watch?v=a2GDsaReFEA)

- [유튜브 (Austin Kim)- 컨텍스트 스위칭이란?](https://www.youtube.com/watch?v=j-oFM8PyFik)

- [techtarget 참고 - context switch](https://www.techtarget.com/whatis/definition/context-switch)

- [memtime 참고 - Context Switching vs Productivity: How to Navigate the Duo](https://www.memtime.com/blog/context-switching-vs-productivity)

- [블로그 참고 - 컨텍스트 스위칭(context switching)(kimunche)](https://velog.io/@kimunche/%EC%BB%A8%ED%85%8D%EC%8A%A4%ED%8A%B8-%EC%8A%A4%EC%9C%84%EC%B9%ADcontext-switching)

- [블로그 참고 - 컨텍스트 스위칭(머신러닝을 배웠던 데이터엔지니어)](https://hyunie-y.tistory.com/31)

- [블로그 참고 - Interrupt와 Context Switching(알쓸코지)](https://coji.tistory.com/170)

