# Process

> 어떤작업이 실행되고 있는 동안의 상태, OS로부터 시스템 자원을 할당받는 작업 단위

![rectangle_icon_144162](https://github.com/BOLTB0X/DataStructure_Argolithm/assets/83914919/1e784bd5-2141-4275-9e9e-c2561e702643)

각 프로세스는 자신만의 가상주소공간을 가지고 있음, OS는 process가 실행될때 이 가상 주소공간을 할당하고, process 내 코드, data, stack, heap, 메모리에 적절히 배치

- 독립성
  각 프로세스는 독립적인 실행 단위를 가지고 다른 프로세스에 영향을 미치지 않음
  즉 각 프로세스는 자신만의 주소공강을 가지고 있어 다른 process에 Data영역(전역 변수, static 변수),나 Code영역(소스 코드)에 직접적인 접근할수없음
  <br/>

- 스캐쥴링
  여러 프로세스가 동시에 실행될 수있지만 실제로는 CPU가 한번에 하나의 process만 실행이 가능
  process 스케줄링이 필요하여 os가 cpu 시간을 process 간에 공정하게 분배하여 process를 실행
  <br/>

- 통신
  process 간의 통신이 필요한 경우 메세지 패싱, 공유 메모리와 같은 방법을 사용하여 data를 교환 (IPC)
  <br/>

- 자원관리
  각 process는 실행에 필요한 자원을 요청하고 사용 (Ex cpu time, file, 메모리, 네트워크 연결)
  OS는 이러한 자원을 관리하여 process 간 공정하게 분배 -> OS에 의해 관리되며 process 생성/종료, 스케쥴링 자원할당 등 작업을 수행

# Multi Process

> 여러 독립적인 process가 동시에 실행 하는 것을 의미

하나의 프로그램을 여러개의 process 를 구성,각 process 마다 하나의 task씩 처리하도록 하는 것

Multi Process는 하나의 프로그램에서 일어나는 여러 개의 작업을 process 를 여러 개 생성하여 각자 하나씩 처리

![rectangle_icon_144162 (1)](https://github.com/BOLTB0X/DataStructure_Argolithm/assets/83914919/6174e2a1-b2f6-441c-9f5a-7494df2fc765)

- 병렬처리
  여러 프로세스가 동시에 실행되므로 시스템 성능을 높임
  <br/>

- 안정성
  각 process 는 독립적으로 실행되기 때문에 한 process 의 오류가 다른 process 에 영향을 미치지 않음 (하나의 process 가 충돌하거나 종료 되더라도 다른 process 는 계속 정상적으로 실행 될 수 있음)
  <br/>

- 보안
  프로세스는 독립적인 주소공간 직접적인프로세스의 Data, Code 에 접근할 수 없음
  <br/>

- 확장성
  cpu 코어 활용 가능 병렬로 실행
  <br/>

- 자원공유의 문제점
  각 프로세스는 메모리가 모두 독립적으로 존재하기 때문에 Context Switching시 Cpu의 부담도 커지고 오버헤드가 발생하게 된다는 것 -> process 간 자원공유가 어려움

> Cf. context Switching
> 시스템 에서 실행중 인 process 나 thread를 변경하는 과정

# Thread

> 한 프로세스 내에서 동작되는 여러 실행의 흐름

프로세스 내에서 동작 되는 것이므로 메모리 영역을 독립적으로 할당 받지 못함

![rectangle_icon_144162 (2)](https://github.com/BOLTB0X/DataStructure_Argolithm/assets/83914919/c9249017-3661-4695-ba77-86e034376f62)

> Stack은 LIFO, Stack이 쌓이면 프로세스가 섞인 채로 순서대로 나와 흐름에 방해를 주기 때문에

Code, Data, Heap 영역은 공유하고 Stack 영역만 독립적으로 할당받을 수 있음

따라서 쓰레드들 끼리는 힙 영역을 공유하여 같은 자원을 접근할 수 있지만,

각자의 스택 영역은 서로 접근할 수 없음

> 힙은 프로그래머가 메모리가 할당하는 영역
> 스택영역은 함수 호출시 함수의 지역변수, 매개변수 리턴 값 등이 저장되고 함수가 종료 되면 메모리 해제
> 컴파일타임에 결정 되기에 무한히 할당 X

# Multi Thread

> 하나의 프로세스 내에서 여러 개의 스레드가 동시에 실행되는 것

하나의 프로그램을 여러 개의 쓰레드로 구성하여, 각 쓰레드마다 하나의 작업(Task)씩 처리하도록 하는 것

![rectangle_icon_144162 (3)](https://github.com/BOLTB0X/DataStructure_Argolithm/assets/83914919/cc217dd1-f924-41e6-9e9d-64a4250354a4)

- 성능 향상
  멀티 스레드를 사용하면 여러 작업을 동시에 처리할 수 있으므로 전체적인 시스템 성능을 향상
  <br/>

- 응답성 향상
  멀티 스레드를 사용하면 프로그램이 여러 작업을 동시에 처리할 수 있으므로 사용자와의 상호 작용이 더 빠르고 반응적으로 이루어지는 것이 가능
  > GUI 애플리케이션에서는 화면 갱신과 사용자 입력 처리를 별도의 스레드에서 처리하여 응답성을 향상 가능

<br/>

- 자원 공유
  멀티 스레드를 사용하면 하나의 프로세스 내에서 자원을 공유 가능 -> 스레드 간에 데이터를 공유하거나 작업을 협력적으로 수행 가능
  <br/>

- 설계가 까다로운 단점
  <br/>

## 참고

[블로그 참조](https://babbab2.tistory.com/63)
