# Process & Thread

> Process : OS 로부터 독립된 메모리 공간을 할당받는 **실행 단위**

> Thread : 하나의 프로세스 내에서 실행되는 여러 작업 **흐름 단위**

<p align="center">
   <img src="https://github.com/BOLTB0X/Swift_Study/blob/main/study/OS/OS.png?raw=true" alt="Example Image" width="100%">
</p>

| 구분 | 프로세스 (Process) | 스레드 (Thread) |
|:------|:-----------------------------|:--------------------------------|
| **정의** | 운영체제로부터 자원을 할당받은 실행 중인 프로그램의 인스턴스 | 하나의 프로세스 내에서 실행되는 작업의 흐름 단위 |
| **메모리** | 각 프로세스는 독립적인 메모리 공간(코드, 데이터, 힙, 스택)을 가짐 | 같은 프로세스의 코드, 데이터, 힙 영역을 공유하고, 스택만 개별적으로 가짐 |
| **통신** | 다른 프로세스와 통신하려면 *IPC(Inter-Process Communication)* 필요 | 같은 프로세스 내의 다른 스레드와 메모리를 공유하므로 통신이 용이 |
| **자원** | 생성 및 컨텍스트 스위칭 비용이 높음 | 프로세스에 비해 생성 및 컨텍스트 스위칭 비용이 낮아 효율적 |
| **안정성** | 한 프로세스의 오류가 다른 프로세스에 영향을 미치지 않음 | 한 스레드의 오류가 같은 프로세스 내의 다른 스레드에 영향을 미칠 수 있음 |
| **주요 용도** | 독립적인 애플리케이션을 실행할 때 | 하나의 애플리케이션 내에서 여러 작업을 동시에 처리해야 할 때 |


---

## Intro: Program

```
프로그램 → 프로세스 → 스레드
```

**프로그램** 은 저장 장치(하드 디스크 등)에 저장되어 있는, 특정 작업을 수행하기 위한 명령어들의 **정적인 집합**

즉, 사용자가 실행하기 전의 상태이며, 그 자체로는 아무런 행동을 하지 않음

- **Program** : 파일이 저장 장치에 저장되어 있지만 메모리에는 올라가 있지 않은 정적인 상태

- **Process** : OS에서 실행되기 위해 메모리를 할당받은 상태

- **Thread** : *하나의 프로세스 안* 에서 **여러 작업을 동시에 수행하기 위한 실행 흐름의 단위**

---

## Process

> 실행 중인 프로그램의 인스턴스

> ex. **“앱 전체”** -> 실행 중인 프로그램의 최소 단위

프로그램이 실행되면 운영체제로부터 메모리, CPU 등 시스템 자원을 할당받아 독립적인 실행 단위가 되는 것

### 특징

<p align="center">
   <img src="https://github.com/BOLTB0X/Swift_Study/blob/main/study/OS/Process1.png?raw=true" alt="Example Image" width="100%">
</p>

1. 각 프로세스는 독립된 주소 공간을 가짐 **(Code, Data, Stack, Heap)**

    - 다른 앱과 메모리 공유 X, ex. *카카오톡 앱이 죽어도 유튜브 앱엔 영향 X*

    - *PID 부여, 메모리 공간 분리* 등 **OS** 가 관리

2. 프로세스 간에는 자원을 공유하기 위해 별도의 통신 메커니즘(IPC: Inter-Process Communication)이 필요

    - 프로세스 간 통신(IPC)은 복잡함 , ex. `Darwin Notification`, `XPC` 사용

### 상태 전이

<p align="center">
   <img src="https://github.com/BOLTB0X/Swift_Study/blob/main/study/OS/%ED%94%84%EB%A1%9C%EC%84%B8%EC%8A%A4%20%EC%83%81%ED%83%9C%EC%A0%84%EC%9D%B4.png?raw=true" alt="Example Image" width="100%">
</p>

1. 생성 (New) : 프로세스 생성 상태

2. 준비 (Ready) : 프로세스가 CPU에 할당 받기를 기달리는 상태

3. 실행 (Running) : 프로세스가 CPU에 할당받아서 실행중인 상태

4. 대기 (Waiting) : 프로세스가 입출력(I/O) 이나 Event를 기다리는 상태

5. 종료 (Terminated) : 프로세스가 실행을 끝내고 종료한 상테

---

## Thread

> **“프로세스 안의 실행 흐름”** —> 코드 실행의 최소 단위

프로세스가 할당받은 자원을 공유하여 작업을 수행 단위 이기도 함

### 정의

<p align="center">
   <img src="https://github.com/BOLTB0X/Swift_Study/blob/main/study/OS/Process2.png?raw=true" alt="Example Image" width="100%">
</p>

- 스레드는 프로세스 내에서 각각 **Stack** 만 따로 할당받고 **Code** , **Data** , **Heap** 영역은 공유
 
- 프로세스는 하나 이상의 스레드를 가질 수 있음

    - ex 웹 브라우저 프로세스 안에서 여러 탭이 동시에 실행되는 것은 여러 스레드가 작동하기 때문

### in iOS

- 앱이 실행되면 기본적으로 메인 스레드가 하나 생성됨 *(UI 담당)*

- 네트워킹, 이미지 로딩 등은 별도 백그라운드 스레드에서 수행

    - ex. `GCD(DispatchQueue)`, `OperationQueue` 이용

- 장점: 메모리 공유로 데이터 교환 빠름 , 컨텍스트 스위칭 비용이 낮음
   
- 단점: 하나의 스레드가 공유 자원에 동시 접근 시 **race condition** , **deadlock** 위험

- 자세한 것은 [iOS 환경에서 Thread](https://github.com/BOLTB0X/SwiftUI/tree/main/study/Thread) 참고

---

## 참고

- [패스트 캠퍼스 - CS 기술면접 단골질문! <프로세스와 스레드 차이>](https://fastcampus.co.kr/media_branding_cs#:~:text=%ED%94%84%EB%A1%9C%EC%84%B8%EC%8A%A4%EB%8A%94%20%EB%8B%A4%EB%A5%B8%20%ED%94%84%EB%A1%9C%EC%84%B8%EC%8A%A4%EC%99%80%20%EC%A0%95%EB%B3%B4%EB%A5%BC%20%EA%B3%B5%EC%9C%A0%ED%95%98%EB%A0%A4%EB%A9%B4%20IPC%EB%A5%BC%20%EC%82%AC%EC%9A%A9%ED%95%98%EB%8A%94,%EB%A9%80%ED%8B%B0%ED%83%9C%EC%8A%A4%ED%82%B9%EB%B3%B4%EB%8B%A4%20%EB%A9%80%ED%8B%B0%EC%8A%A4%EB%A0%88%EB%93%9C%EA%B0%80%20%EC%9E%90%EC%9B%90%EC%9D%84%20%EC%95%84%EB%82%84%20%EC%88%98%20%EC%9E%88%EA%B2%8C%20%EB%90%9C%EB%8B%A4.)

- [유튜브 - Process vs Thread(10분 테코톡)](https://www.youtube.com/watch?v=1grtWKqTn50)

- [유튜브 - Process와 Thread의 차이(널널한 개발자 TV)](http://youtube.com/watch?v=x-Lp-h_pf9Q)

- [블로그 참고 - 프로세스와 스레드의 차이(개발장)](https://velog.io/@raejoonee/%ED%94%84%EB%A1%9C%EC%84%B8%EC%8A%A4%EC%99%80-%EC%8A%A4%EB%A0%88%EB%93%9C%EC%9D%98-%EC%B0%A8%EC%9D%B4#:~:text=%ED%94%84%EB%A1%9C%EC%84%B8%EC%8A%A4:%20%EC%9A%B4%EC%98%81%EC%B2%B4%EC%A0%9C%EB%A1%9C%EB%B6%80%ED%84%B0%20%EC%9E%90%EC%9B%90%EC%9D%84%20%ED%95%A0%EB%8B%B9%EB%B0%9B%EC%9D%80%20%EC%9E%91%EC%97%85%EC%9D%98%20%EB%8B%A8%EC%9C%84.%20%EC%8A%A4%EB%A0%88%EB%93%9C:%20%ED%94%84%EB%A1%9C%EC%84%B8%EC%8A%A4%EA%B0%80%20%ED%95%A0%EB%8B%B9%EB%B0%9B%EC%9D%80%20%EC%9E%90%EC%9B%90%EC%9D%84%20%EC%9D%B4%EC%9A%A9%ED%95%98%EB%8A%94%20%EC%8B%A4%ED%96%89%20%ED%9D%90%EB%A6%84%EC%9D%98%20%EB%8B%A8%EC%9C%84.)

- [블로그 참고 - 프로세스와 스레드(태크민의 우당탕탕 개발 블로그)](https://jtm0609.tistory.com/163)

- [블로그 참고 - 운영체제 프로세스(Process) 상태 전이도(PureStack)](https://wookkingkim.tistory.com/entry/%EC%9A%B4%EC%98%81%EC%B2%B4%EC%A0%9C%ED%94%84%EB%A1%9C%EC%84%B8%EC%8A%A4Process-%EC%83%81%ED%83%9C-%EC%A0%84%EC%9D%B4%EB%8F%84)

- [블로그 참고 - 컨텍스트 스위칭(context switching)(kimunche)](https://velog.io/@kimunche/%EC%BB%A8%ED%85%8D%EC%8A%A4%ED%8A%B8-%EC%8A%A4%EC%9C%84%EC%B9%ADcontext-switching)