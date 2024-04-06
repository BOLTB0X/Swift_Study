# Stack Over Flow

> 스택에 너무 과도한 메모리를 할당하게 되어 스택 영역을 초과한 경우

## 간략한 메모리 구조와 동작방식

1. **Code**

   - IDE / 에디터에 코드를 작성하면 컴파일이 되기 전에 이미 사전 처리를 하게 됨
     <br/>
   - 사전 처리는 대부분 헤더 파일과 밀접한 관련이 있음(swift에는 헤더 파일이 별도로 존재 X)
     <br/>
   - 컴파일을 시작하면 human level 에서 작성한 코드를 machine level code 로 변환
     <br/>
   - **변환 된 코드가 메모리 영역으로 이동하여 저장 되는 것\_**
     <br/>

2. **Loading**

   - 작성한 변수든 함수든 이 모든 코드가 메모리 영역에 배정
     <br/>
   - 만든 모든 entity를 메모리 영역으로 옮기는 것을 Loading
     <br/>
   - 이 역할을 하는 것이 loder, 이때 프로그램을 돌리는 메모리 영역을 **Randon Access Memory**
     <br/>

3. **RAM**
   - 첫 번째 세그먼트: 머신 레벨의 코드를 저장하는 머신코드
     <br/>
   - 두 번째 세그먼트: Stack
     <br/>
   - 세번째 세그먼트: Heap

## Stack Frame

> 스택 영역에 차례대로 저장되는 함수의 호출 정보를 **스택 프레임(stack frame)**

이러한 스택 프레임 덕분에 함수의 호출이 모두 끝난 뒤에, 해당 함수가 호출되기 이전 상태로 되돌아갈 수 있는 것

```swift
func mainFunc() {
    Func1() // 함수 1 호출
}

func Func1() {
    Func2() // 함수 2 호출
}

func Func2() {

}

mainFunc()
```

위 코드에서 함수 호출에 의한 스택 프레임의 변화를 그림으로 나타내면

![img](http://www.tcpschool.com/lectures/img_c_stackframe_01.png)
<br/>

![img](http://www.tcpschool.com/lectures/img_c_stackframe_02.png)
<br/>

- Step 1. 프로그램이 실행되면, 가장 먼저 main() 함수가 호출되어 main() 함수의 Stack frame 이 stack 에 저장
  <br/>
- Step 2. func1() 함수를 호출하면 해당 함수의 매개변수, 반환 주소값, 지역 변수 등의 Stack fram 이 stack 에 저장
  <br/>
- Step 3. func2() 함수를 호출하면 해당 함수의 Stack frame 이 추가로 stack 에 저장
  <br/>
- Step 4. func2() 함수의 모든 작업이 완료되어 반환되면, func2() 함수의 Stack frame 만이 stack 에서 제거
  <br/>
- Step 5. func1() 함수의 호출이 종료되면, func1() 함수의 Stack frame 이 stack 에서 제거
  <br/>
- Step 6. main() 함수의 모든 작업이 완료되면, main() 함수의 Stack frame 이 stack 에서 제거되면서 프로그램이 종료
  <br/>

이 과정을 통해 알 수 있듯히 스택 영역은 가장 나중에 저장된 데이터가 가장 먼저 인출되는 방식으로 동작

이러한 방식을 후입선출(LIFO, Last-In First-Out), stack은 push 동작으로 data를 저장하고, pop 동작으로 data 를 인출

## 스택 오버플로우(stack overflow)

> 선입후출 특성 때문에 무한이란 문제가 생김

```swift
// 파라미터로 전달해온 a를 1씩 증가시켜주는 함수
func plusOne(_ a: Int) {
    if a == 0 {
        return
    }
    var a = a // 참고로 매개변수는 let

    a += 1
    print(a)
    plusOne(a)
}

func makeA() {
    let a:Int = 0
    plusOne(a)
}

makeA() // 무한히 호출
```

예제 코드를 보면 결국 재귀 호출이 무한히 반복되면, 위 그림에서 Step 3 이후로는 재귀 호출에 의한 Stack frame이 계속해서 쌓여만 갈 것

이렇게 stack의 모든 공간을 다 차지하고 난 후 더 이상의 여유 공간이 없을 때, 또 다시 Stack frame을 저장하게 되면, 해당 데이터는 stack 영역을 넘어가서 저장되게 됨

![img](http://www.tcpschool.com/lectures/img_c_stackoverflow.png)

## 참고

[tcpschool 참고](http://www.tcpschool.com/c/c_memory_stackframe)

[블로그 참고](https://ios-developer-storage.tistory.com/entry/iOSSwift-%EC%8A%A4%ED%83%9DStack%EA%B3%BC-%EC%8A%A4%ED%83%9D-%EC%98%A4%EB%B2%84%ED%94%8C%EB%A1%9C%EC%9A%B0%EB%9E%80-%EC%98%88%EC%A0%9C%EB%A1%9C-%EC%95%8C%EC%95%84%EB%B3%B4%EA%B8%B0)
