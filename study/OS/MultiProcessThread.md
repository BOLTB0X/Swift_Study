# Multi Process & Multi Thread

> 멀티 프로세스와 멀티 스레드는 모두 여러 작업을 동시에 처리하는 [Concurrency](https://github.com/BOLTB0X/Swift_Study/tree/main/swiftGrammar/Concurrency)을 달성하기 위한 방법


- 한 어플리케이션에 대한 처리방식

- 그 기본 단위와 자원 관리 방식에 큰 차이가 있음

---

## 멀티 프로세스(Multi-process)

<p align="center">
   <img src="https://github.com/BOLTB0X/Swift_Study/blob/main/study/OS/%EB%A9%80%ED%8B%B0%ED%94%84%EB%A1%9C%EC%84%B8%EC%8B%B1.png?raw=true" alt="Example Image" width="70%">
</p>

**OS가 여러 개의 독립적인 프로세스들을 동시에 실행하는 것**

- 각 프로세스 간 메모리 구분이 필요하거나 독립된 주소 공간을 가져야 할 경우 사용

- 주로 하나의 프로그램 실행에 대해 하나의 프로세스가 메모리에 생성되지만, 부가적인 기능을 위해 여러개의 프로세스를 생성하기도 함

- *ex. 멀티 프로세스는 웹 브라우저에서의 여러 탭이나 여러 창*

<p align="center">
   <img src="https://github.com/BOLTB0X/Swift_Study/blob/main/study/OS/%ED%94%84%EB%A1%9C%EC%84%B8%EC%8A%A4%EB%B6%80%EB%AA%A8%EC%9E%90%EC%8B%9D.png?raw=true" alt="Example Image" width="60%">
</p>

>  하나의 부모 프로세스가 여러 개의 자식 프로세스를 생성함으로서 다중 프로세스를 구성하는 구조

### 특징


#### 독립적인 메모리 공간

- 각 프로세스는 OS로부터 별도의 메모리 공간(코드, 데이터, 힙, 스택)을 할당받음

- 이는 한 프로세스가 다른 프로세스의 메모리에 직접 접근할 수 없음을 의미

#### 프로세스 간 통신(IPC) 필요

- 데이터를 공유하려면 복잡한 **IPC(Inter-Process Communication)** 방식을 사용해야 함

#### 높은 안정성

- 한 프로세스에 문제가 발생해도 다른 프로세스에 영향을 주지 않으므로, 시스템 전체의 안정성이 높음

#### 느린 컨텍스트 스위칭

- 프로세스 간 컨텍스트 스위칭은 독립된 메모리 공간의 모든 상태를 저장하고

- 복원해야 하므로 오버헤드가 크고 속도가 느림

#### 많은 리소스 소모

- 각 프로세스가 독립된 자원을 할당받으므로, 많은 시스템 자원이 소모됌

### 장점

- **안정성**
    
    오류가 다른 프로세스에 영향을 주지 않아 견고한 시스템을 구축할 수 있음

- **격리성**

    독립된 메모리 공간으로 인해 보안성이 높음

### 단점

- **높은 오버헤드**

    컨텍스트 스위칭 비용이 커서 성능에 불이익이 있을 수 있음

- **복잡한 통신**

    프로세스 간 데이터 공유가 번거로움

---

## 멀티 스레드(Multi-thread)

<p align="center">
   <img src="https://github.com/BOLTB0X/Swift_Study/blob/main/study/OS/%EB%A9%80%ED%8B%B0%EC%8A%A4%EB%A0%88%EB%93%9C.png?raw=true" alt="Example Image" width="70%">
</p>

**하나의 프로세스 안에서 여러 개의 스레드(실행 흐름)를 생성하여 작업을 동시에 처리하는 방식**

- 하나의 프로그램에서 두가지 이상의 동작을 동시에 처리하도록 하는 행위가 가능해지는 것

- 여러 스레드 중, 어떤 *A 스레드* 가 지연되더라도, *B 스레드* 는 작업을 지속할 수 있음

- *ex. 멀티 스레드는 웹 브라우저의 단일 탭 또는 창 내에서 브라우저 이벤트 루프, 네트워크 처리, I/O 및 기타 작업을 관리하고 처리*

### 특징

<p align="center">
   <img src="https://github.com/BOLTB0X/Swift_Study/blob/main/study/OS/%EB%A9%80%ED%8B%B0%EC%8A%A4%EB%A0%88%EB%93%9C%EC%98%88%EC%8B%9C.png?raw=true" alt="Example Image" width="60%">
</p>

#### 메모리 공유

<p align="center">
   <img src="https://github.com/BOLTB0X/Swift_Study/blob/main/study/OS/%EC%8B%B1%EA%B8%80.png?raw=true" alt="Example Image" width="40%">
    <img src="https://github.com/BOLTB0X/Swift_Study/blob/main/study/OS/%EB%A9%80%ED%8B%B0%EC%8A%A4%EB%A0%88%EB%93%9C%ED%94%84%EB%A1%9C%EC%84%B8%EC%8A%A4.png?raw=true" alt="Example Image" width="40%">
</p>


- 같은 프로세스 내의 스레드들은 코드, 데이터, 힙 영역을 공유하고, 각자 독립적인 스택만 가짐

#### 쉬운 데이터 공유

- 메모리 공간을 공유하므로 스레드 간 데이터 통신이 매우 쉽고 빠름

#### 낮은 안정성

- 한 스레드에 문제가 생기면 같은 프로세스 내의 다른 스레드에 영향을 주어 전체 프로세스가 종료될 수 있음

#### 빠른 컨텍스트 스위칭

- 스택, 레지스터, 프로그램 카운터(PC) 등 최소한의 정보만 전환하므로 오버헤드가 적고 속도가 빠름

#### 적은 자원 소모

- 프로세스 생성보다 스레드 생성이 더 적은 자원을 사용

### 장점

- **자원 효율성**

    메모리를 공유하므로 시스템 자원을 절약 가능

- **빠른 통신**

    스레드 간 데이터 통신이 쉽고 효율적

- **낮은 오버헤드**

    컨텍스트 스위칭이 빨라 성능이 향상

### 단점

- **동기화 문제**

    여러 스레드가 공유 자원에 동시에 접근하면서 데이터 충돌이나 교착 상태(데드락)가 발생할 수 있는데
    
    이를 해결하기 위해 동기화 메커니즘을 사용해야 함

- **안정성 문제**

    하나의 스레드 결함이 전체 프로세스의 치명적인 오류로 이어질 수 있음

- 디버깅의 어려움

    공유 자원 문제로 인해 디버깅이 복잡해질 우려

---

## 참고

- [유튜브 - 프로세스는 뭐고 스레드는 뭔가요?(얄팍한 코딩사전)](https://www.youtube.com/watch?v=iks_Xb9DtTM&t=5s)

- [유튜브 - 프로세스, 스레드, 멀티태스킹, 멀티스레딩, 멀티프로세싱, 멀티프로그래밍까지 한 방에 깔끔하게 설명합니다!! 콘텐츠 퀄리티 만족하실 겁니다!(쉬운코드)](https://www.youtube.com/watch?v=QmtYKZC0lMU)

- [유튜브 - 멀티코어 CPU와 함께하는 프로세스와 스레드의 이해(woozoobro)](https://www.youtube.com/watch?v=hwJi4ap5aAk)

- [F-Lab - 멀티 프로세스와 멀티 스레드의 차이점과 적용 사례](https://f-lab.kr/insight/multi-process-vs-multi-thread?gad_source=1&gclid=CjwKCAjwjqWzBhAqEiwAQmtgT9rK6c8J_6jsf_CwKalPSsJvcmOpDgMKPsQVzXIUbqvls2D11SHxshoCjsEQAvD_BwE)

- [Medium - Multithreading in iOS-Part(Manasa)](https://medium.com/geekculture/threads-in-ios-gcd-nsoperation-part-1-64e460c0bdea)

- [블로그 참고 - 멀티 프로세스 vs 멀티 스레드 비교(인파)](https://inpa.tistory.com/entry/%F0%9F%91%A9%E2%80%8D%F0%9F%92%BB-multi-process-multi-thread)

- [블로그 참고 - 멀티 프로세스 vs 멀티 스레드(sam0308)](https://sam0308.tistory.com/12#:~:text=%EC%97%AC%EB%9F%AC%EA%B0%9C%EC%9D%98%20%ED%94%84%EB%A1%9C%EC%84%B8%EC%8A%A4%EB%A5%BC%20%EB%8F%99%EC%8B%9C%EC%97%90%20%EC%8B%A4%ED%96%89%ED%95%98%EB%8A%94%20%EA%B2%83%EC%9D%84%20%EB%A9%80%ED%8B%B0%ED%94%84%EB%A1%9C%EC%84%B8%EC%8A%A4,%EC%97%AC%EB%B6%80%EC%97%90%EC%84%9C%20%EC%B0%A8%EC%9D%B4%EA%B0%80%20%EC%9E%88%EC%8A%B5%EB%8B%88%EB%8B%A4.)

- [블로그 참고 - 멀티 프로세스(Multi Process)와 멀티 스레드(Multi Thread)(wooody92)](https://wooody92.github.io/os/%EB%A9%80%ED%8B%B0-%ED%94%84%EB%A1%9C%EC%84%B8%EC%8A%A4%EC%99%80-%EB%A9%80%ED%8B%B0-%EC%8A%A4%EB%A0%88%EB%93%9C/#:~:text=%EB%A9%80%ED%8B%B0%20%EC%8A%A4%EB%A0%88%EB%93%9C%EB%8A%94%20%EB%A9%80%ED%8B%B0%20%ED%94%84%EB%A1%9C%EC%84%B8%EC%8A%A4%EB%B3%B4%EB%8B%A4%20%EC%A0%81%EC%9D%80%20%EB%A9%94%EB%AA%A8%EB%A6%AC%20%EA%B3%B5%EA%B0%84%EC%9D%84,%EC%95%8A%EC%95%84%20%EC%95%88%EC%A0%95%EC%84%B1%EC%9D%B4%20%EB%86%92%EC%A7%80%EB%A7%8C%2C%20%EB%A9%80%ED%8B%B0%20%EC%8A%A4%EB%A0%88%EB%93%9C%EB%B3%B4%EB%8B%A4%20%EB%A7%8E%EC%9D%80%20%EB%A9%94%EB%AA%A8%EB%A6%AC%EA%B3%B5%EA%B0%84%EA%B3%BC)

- [블로그 참고 - 멀티 프로세스 대신 멀티 스레드를 사용하는 이유는 무엇인가요?(yeeeon89)](https://jyhistory.tistory.com/m/12#:~:text=%EB%A9%80%ED%8B%B0%20%ED%94%84%EB%A1%9C%EC%84%B8%EC%8A%A4%EC%99%80%20%EB%A9%80%ED%8B%B0%20%EC%8A%A4%EB%A0%88%EB%93%9C%EB%A9%80%ED%8B%B0%20%ED%94%84%EB%A1%9C%EC%84%B8%EC%8A%A4%20:%20%ED%95%98%EB%82%98%EC%9D%98,%EC%9E%88%EB%8B%A4.%EC%8A%A4%EB%A0%88%EB%93%9C%20%EA%B0%84%20%ED%86%B5%EC%8B%A0%20%EB%B9%84%EC%9A%A9%EC%9D%B4%20%EC%A0%81%EA%B3%A0%20%EC%9D%91%EB%8B%B5%20%EC%8B%9C%EA%B0%84%EC%9D%B4)