# 스택 오버 플로우

<br/>

![img](https://cdn.icon-icons.com/icons2/602/PNG/512/Stack_Overflow_icon-icons.com_55812.png)
<br/>

스택에 너무 과도한 메모리를 할당하게 되어 스택 영역을 초과한 경우
<br/>

## 간략한 메모리 구조와 동작방식

IDE/에디터에 코드를 작성하면 컴파일이 되기 전에 이미 사전 처리를 하게 됨
<br/>

사전 처리는 대부분 헤더 파일과 밀접한 관련이 있음(swift에는 헤더 파일이 별도로 존재 X)
<br/>

컴파일을 시작하면 "human level"에서 작성한 코드를 "machine level code"로 변환
<br/>

여기서 **_변환 된 코드가 메모리 영역으로 이동하여 저장 되는 것_**
<br/>

작성한 변수든 함수든 이 모든 코드가 메모리 영역에 배정 -> 만든 모든 entity를 메모리 영역으로 옮기는 것을 Loading(로딩)
<br/>

이 역할을 하는 것이 로더 이고 이 때 프로그램을 돌리는 메모리 영역을 **Randon Access Memory**, 즉 램이라 함
<br/>

램은 몇 가지 세그먼트로 나눠진다 생각하면 됌
<br/>

1. 첫 번째 세그먼트: 머신 레벨의 코드를 저장하는 머신코드
   <br/>

2. 두 번째 세그먼트: Stack(스택)
   <br/>

3. 세번째: Heap(힙)
   <br/>

## 스택 프레임

> 메모리의 스택(stack) 영역은 함수의 호출과 관계되는 지역 변수와 매개변수가 저장되는 영역
> <br/>
> 스택 영역은 함수의 호출과 함께 할당되며, 함수의 호출이 완료되면 소멸
> <br/>
> 함수가 호출되면 스택에는 함수의 매개변수, 호출이 끝난 뒤 돌아갈 반환 주소값, 함수에서 선언된 지역 변수 등이 저장
> <br/>
> 이렇게 스택 영역에 차례대로 저장되는 함수의 호출 정보를 **스택 프레임(stack frame)** > <br/>
> 이러한 스택 프레임 덕분에 함수의 호출이 모두 끝난 뒤에, 해당 함수가 호출되기 이전 상태로 되돌아갈 수 있는 것
> <br/>

<br/>

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

위 예제 코드에서 함수 호출에 의한 스택 프레임의 변화를 그림으로 나타내면
<br/>

![img](http://www.tcpschool.com/lectures/img_c_stackframe_01.png)
<br/>

![img](http://www.tcpschool.com/lectures/img_c_stackframe_02.png)
<br/>

Step 1. 프로그램이 실행되면, 가장 먼저 main() 함수가 호출되어 main() 함수의 스택 프레임이 스택에 저장
<br/>

Step 2. func1() 함수를 호출하면 해당 함수의 매개변수, 반환 주소값, 지역 변수 등의 스택 프레임이 스택에 저장
<br/>

Step 3. func2() 함수를 호출하면 해당 함수의 스택 프레임이 추가로 스택에 저장
<br/>

Step 4. func2() 함수의 모든 작업이 완료되어 반환되면, func2() 함수의 스택 프레임만이 스택에서 제거
<br/>

Step 5. func1() 함수의 호출이 종료되면, func1() 함수의 스택 프레임이 스택에서 제거
<br/>

Step 6. main() 함수의 모든 작업이 완료되면, main() 함수의 스택 프레임이 스택에서 제거되면서 프로그램이 종료
<br/>
<br/>

이 과정을 통해 알 수 있듯히 스택 영역은 가장 나중에 저장된 데이터가 가장 먼저 인출되는 방식으로 동작
<br/>

이러한 방식을 후입선출(LIFO, Last-In First-Out), 스택은 푸시(push) 동작으로 데이터를 저장하고, 팝(pop) 동작으로 데이터를 인출
<br/>

## 스택 오버플로우(stack overflow)

선입후출 특성 때문에 무한이란 문제가 생김
<br/>

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

<br/>

예제 코드를 보면 결국 재귀 호출이 무한히 반복되면, 위 그림에서 Step 3 이후로는 재귀 호출에 의한 스택 프레임이 계속해서 쌓여만 갈 것
<br/>

이렇게 스택의 모든 공간을 다 차지하고 난 후 더 이상의 여유 공간이 없을 때 또 다시 스택 프레임을 저장하게 되면, 해당 데이터는 스택 영역을 넘어가서 저장되게 됨
<br/>

![img](http://www.tcpschool.com/lectures/img_c_stackoverflow.png)
<br/>

## 참고

http://www.tcpschool.com/c/c_memory_stackframe
<br/>
https://ios-developer-storage.tistory.com/entry/iOSSwift-%EC%8A%A4%ED%83%9DStack%EA%B3%BC-%EC%8A%A4%ED%83%9D-%EC%98%A4%EB%B2%84%ED%94%8C%EB%A1%9C%EC%9A%B0%EB%9E%80-%EC%98%88%EC%A0%9C%EB%A1%9C-%EC%95%8C%EC%95%84%EB%B3%B4%EA%B8%B0
<br/>
