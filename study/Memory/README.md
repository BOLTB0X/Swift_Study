# 메모리 구조

> 프로그램이 실행되기 위해서는 먼저 프로그램이 메모리에 로드(load)되어야 함<br/>
> 또한, 프로그램에서 사용되는 변수들을 저장할 메모리도 필요

<p align="center">
   <img src="https://github.com/BOLTB0X/Swift_Study/blob/main/study/OS/Process1.png?raw=true" alt="Example Image" width="70%">
</p>

OS는 RAM에 프로그램을 실행을 위헤 메모리를 load하는 데 이걸 **Code** , **Data** , **Heap**, **Stack** 공간에 할당

---

## Code 영역

> 메모리의 code 영역은 실행할 프로그램의 코드가 저장되는 영역으로 텍스트 영역

CPU는 코드 영역에 저장된 명령어를 하나씩 가져가서 처리하게 됨

즉 소스 코드를 작성하면 **'그 소스 코드'가 기계어(어셈블리)형태로 저장(적재)** 되는 메모리 영역

---

## Data 영역

> 메모리의 data 영역은 프로그램의 global 변수와 static 변수가 저장되는 영역<br/>
> data 영역은 프로그램의 시작과 함께 할당되며, 프로그램이 종료되면 메모리가 해체(소멸)

실행 도중 변수 값이 변경될 가능성이 있으니 **_Read-Write_**

```swift
struct Human {
    static let name = "B0X" // 스태틱 변수로 data영역에 할당
}

var part: String? // 전역 변수로 데이터 영역에 할당
var age: Int? // 전역 변수로 데이터 영역에 할당
```

## Heap 영역

> 메모리의 heap 영역은 사용자가 직접 관리할 수 있고(해야만 하는) 메모리 영역

- heap 영역은 사용자에 의해 메모리 공간이 동적으로 할당되고 해제 됨

- heap 영역은 메모리의 낮은 주소에서 높은 주소의 방향으로 할당 됨

-> **_프로그래머가 할당 / 해제 하는 영역_**

malloc, calloc으로 힙에 메모리를 할당이 가능 -> "동적할당"

동적할당 후 사용한 메모리는 반드시 메모리 해제를 해줘야 함 -> **Memory leak** 방지

다른 영역들과 다르게 런타임 시에 결정됨 -> data의 크기가 확실하지 않을 때 주로 사용

**cf. in swift**

> 객체의 참조값(Object Reference)이 이 heap 영역에 저장되는 대표적인 data

swift에선 **Class Instance, Closure 같은 참조 타입의 값은 힙(Heap) 영역에 자동 할당** 됌

사용 후 메모리를 반드시 해제줘야 하는데 swift에선 ARC를 통해 heap에 할당된 메모리가 더 이상 사용하지 않으면(참조되지 않으면) 자동으로 해제

- heap의 장점

  - 메모리 크기에 대한 제한 X
    
  - 본질적인 범위가 전역이기 때문에, 프로그램의 모든 함수에서 액세스 할 수 있음
    

- heap의 단점
  - 할당작업, 해제 작업으로 인한 속도 저하
    
  - heap 손상(이중 해제, 해제 후 사용 등) 작업으로 인한 속도 저하
    
  - heap 병합(두 개 이상 쓰레드가 동시에 접근하려 할 때 Lock이 걸림)으로 인한 속도 저하
    
  - 메모리를 직접 관리해야 함(해제해주지 않을 시 메모리 누수 발생)

---

## Stack 영역

> 메모리의 stack 영역은 함수의 호출과 관계되는 지역 변수와 매개변수가 저장되는 영역

Stack 영역은 함수의 호출과 함께 할당되며, 함수의 호출이 완료되면 소멸

이렇게 stack 영역에 저장되는 함수의 호출 정보를 [Stack frame](https://github.com/BOLTB0X/Swift_Study/tree/main/study/StackOverFlow#stack-frame)이라 함

함수 호출시 함수의 local 변수, 매개변수, 리턴 값 등이 저장, 함수가 종료가 되면 저장된 메모리도 해체

컴파일 타임에 결정되기 때문에 무한히 할당할 수가 없음

```swift
func addFunc(_ a:Int, _ b:Int) -> Int { // 파라미터는 스택에 할당
    let ret = a + b // local 변수 또한 스택에 할당

    return ret
}

// addFunc 함수가 종료되는 시점에 스택에 저장된 메모리는 자동으로 반환됨
```

선입후출 데이터 구조이므로 CPU에 의해 관리되고 최적화 되어 속도가 매우 빠름

- Stack의 장점

  - CPU가 Stack 메모리를 효율적으로 구성하기 때문에 속도가 매우 빠름

  - 메모리를 직접 해제를 해주지 않아도 됨


- Stack의 단점

  - 메모리 크기에 대한 제한 있음 -> 무한히 할당 X
    
  - local 변수만 액세스 가능

---

## 각 영역의 관계

1. Heap 과 Stack

   - data 의 크기를 정확히 알수 없거나 Stack 에 할당(저장)하기엔 큰 data 의 경우엔 Heap 에 할당

   - 그 외의 경우는 Stack 에 할당

   - 만약 Stack에 많은 data가 할당하게 되면 -> [스택 오버플로우](https://github.com/BOLTB0X/Swift_Study/tree/main/study/StackOverFlow)

2. 메모리 관계

   - Heap 영역은 낮은 메모리 주소부터 할당 받는 것이고, Stack 영역은 높은 메모리 주소부터 할당 받는 것임

   - Heap 또한 자신의 영역 외로 확장을 계속하면 **힙 오버 플로우** 발생

  ---

## 참고

[TCP School - 메모리의 구조](http://www.tcpschool.com/c/c_memory_structure)

[블로그 참고 - 메모리 구조 (Code, Data, Stack, Heap)(개발자 소들이)](https://babbab2.tistory.com/25_)

[블로그 참고 - 프로세스의 메모리 영역(새로비)](https://engkimbs.tistory.com/147)

[블로그 참고 - 메모리 구조 / 스택(Stack), 힙(Heap), 데이터(Data)(코딩 시그널:티스토리)](https://junghn.tistory.com/entry/%EC%BB%B4%ED%93%A8%ED%84%B0-%EA%B8%B0%EC%B4%88-%EB%A9%94%EB%AA%A8%EB%A6%AC-%EA%B5%AC%EC%A1%B0-%EC%8A%A4%ED%83%9DStack-%ED%9E%99Heap-%EB%8D%B0%EC%9D%B4%ED%84%B0Data%EC%98%81%EC%97%AD)
