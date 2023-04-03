# 백준 > 삼성기출문제 > 20055 > 컨베이어 벨트 위의 로봇

## 문제

Gold 5
<br/>
문제링크 : https://www.acmicpc.net/problem/20055
문제설명, 제한사항 생략
<br/>

## Intro

시뮬레이션 문제이며 회전과 깐깐한 구현 조건을 생각해야하는 문제
<br/>

## 풀이

<img src="https://upload.acmicpc.net/396139ea-9079-4115-9a00-446865434900/-/preview/" width="200" height="200"/>

벨트가 한칸 씩 회전하면서 문제 조건을 고려해서 말 그대로 깡으로 구현하는 문제임
<br/>

문제에서 핵심은 딱 2 포인트임
<br/>

> 컨베이어 벨트에 박스 모양 로봇을 하나씩 올리려고 한다. 로봇은 올리는 위치에만 올릴 수 있다. 언제든지 로봇이 내리는 위치에 도달하면 그 즉시 내린다.
> <br/>
> 로봇은 컨베이어 벨트 위에서 스스로 이동할 수 있다. 로봇을 올리는 위치에 올리거나 로봇이 어떤 칸으로 이동하면 그 칸의 내구도는 즉시 1만큼 감소한다.
> <br/>

> 1. 벨트가 각 칸 위에 있는 로봇과 함께 한 칸 회전한다.
>    <br/>
> 2. 가장 먼저 벨트에 올라간 로봇부터, 벨트가 회전하는 방향으로 한 칸 이동할 수 있다면 이동한다. 만약 이동할 수 없다면 가만히 있는다.
>    <br/>
>    2.1 로봇이 이동하기 위해서는 이동하려는 칸에 로봇이 없으며, 그 칸의 내구도가 1 이상 남아 있어야 한다.
>    <br/>
> 3. 올리는 위치에 있는 칸의 내구도가 0이 아니면 올리는 위치에 로봇을 올린다.
>    <br/>
> 4. 내구도가 0인 칸의 개수가 K개 이상이라면 과정을 종료한다. 그렇지 않다면 1번으로 돌아간다.
>    <br/>

로봇과 벨트를 나타내는 구조는

```cpp
struct Block {
    int d; // 내구도
    int robot; // 로봇의 유무
};
```

먼저 while문으로 시뮬레이션을 나타내고 저 문제조건을 진행하고 시뮬레이션 수를 카운팅하는 구조로 잡음
<br/>

그 다음 생각해야할 것은 회전임 처음 그림을 보고 어떻게 옆으로 트는 형태로 회전시킬까 고민했었음
<br/>

but 그림에 위에만 로봇을 올리고 그 아래부분은 이동만 하니 그냥 -> 이 방향으로 회전만 하면 되는 거였음
<br/>

```cpp
void rotateBelts(int n, int k, Block* belts) {
    // 회전을 할것이니 임시 마지막 위치 따로 뺴놓음
    Block tmp = belts[2*n];

    // 1 1 1 1 1 있다 가정하면
    // 1 1 1 1 0 마직막을 따로 빼놓고
    // 0 1 1 1 1 이런 식으로 한 칸식 뒤로 미룸
    for (int i = (2*n)-1; i >= 1; --i) {
        belts[i+1] =belts[i]; // 현재 칸의 뒤로 옮겨줌
    }

    // 첫번쨰가 비워졌으니
    belts[1] = tmp;

    // ****************************//
    // 내리는 칸에 로봇이 있다면
    if (belts[n].robot == 1)
        belts[n].robot = 0;

    return;
}
```

\*표가 된 것을 주목
<br/>

문제 설명의 포인트에서 **_언제든지 로봇이 내리는 위치에 도달하면 그 즉시 내린다._** 라 설명함
<br/>

즉 회전을 할때마다 (배열을 움직일떄마다) 내리는 칸을 체크해야한다는 것
<br/>

그 다음 회전을 했으니 로봇을 옮길 수 있는지 체크

```cpp
void movingRobot(int n, int k, Block* belts) {
    // 로봇이 한 칸 앞으로 옮길 수 있냐가 관건
    // for문을 생각할 때 현재 로봇을 옮기는 칸의 전을 기준으로 생각해야함
    for (int i = n - 1; i >= 1; --i) {
        // 로봇이 있다면
        if (belts[i].robot == 1) {
            // 다음 칸에 로봇이 없고 내구도가 0보다 크다면
            if (belts[i+1].robot == 0 && belts[i+1].d > 0) {
                belts[i].robot = 0; // 로봇이 이동했으니
                belts[i+1].robot = 1;
                belts[i+1].d --; // 내구도 감소
            }
        }
    }

    // 내리는 칸에 로봇이 있다면
    if (belts[n].robot == 1)
        belts[n].robot = 0;

    return;
}
```

<br/>
그 다음 문제 조건의 로봇을 추가하는 함수를 작성

```cpp
void isAddingRobot(int n, int k, Block* belts) {
    // 내구도도 0이 아니고 로봇이 없다면
    if (belts[1].d > 0 && belts[1].robot == 0) {
        belts[1].d -= 1;
        belts[1].robot = 1;
    }

    return;
}
```

문제의 디테일한 부분들은 생략하는 이유는 진짜 문제내용대로 코드를 짜면 됌
<br/>

이를 문제에서 제시하는 순서대로 while문에 넣으면 끝임
<br/>

## 최종 코드

```cpp
//
//  main.cpp
//  PS20055
//
//  Created by KyungHeon Lee on 2023/04/03.
//

#include <iostream>

using namespace std;

// MARK: 회전하는 벨트의 한 블록
struct Block {
    int d; // 내구도
    int robot; // 로봇의 유무
};

// MARK: 탈출 함수
// 내구도가 0인게 K이상인 지 확인
int isBreak(int n, int k, Block* belts) {
    int cnt = 0;

    // for문 완전탐색으로 내구도 0을 체크
    for (int i = 1; i <= 2*n; ++i) {
        if (belts[i].d == 0)
            cnt++; // 카운트
    }

    // 삼항연산자 이용
    return cnt >= k ? 1 : 0;
}

// MARK: 벨트 회전
void rotateBelts(int n, int k, Block* belts) {
    // 회전을 할것이니 임시 마지막 위치 따로 뺴놓음
    Block tmp = belts[2*n];

    // 1 1 1 1 1 있다 가정하면
    // 1 1 1 1 0 마직막을 따로 빼놓고
    // 0 1 1 1 1 이런 식으로 한 칸식 뒤로 미룸
    for (int i = (2*n)-1; i >= 1; --i) {
        belts[i+1] =belts[i]; // 현재 칸의 뒤로 옮겨줌
    }

    // 첫번쨰가 비워졌으니
    belts[1] = tmp;

    // 내리는 칸에 로봇이 있다면
    if (belts[n].robot == 1)
        belts[n].robot = 0;

    return;
}

// MARK: 로봇 올리기
void isAddingRobot(int n, int k, Block* belts) {
    // 내구도도 0이 아니고 로봇이 없다면
    if (belts[1].d > 0 && belts[1].robot == 0) {
        belts[1].d -= 1;
        belts[1].robot = 1;
    }

    return;
}

// MAK: 로봇있니?
void movingRobot(int n, int k, Block* belts) {
    // 로봇이 한 칸 앞으로 옮길 수 있냐가 관건
    // for문을 생각할 때 현재 로봇을 옮기는 칸의 전을 기준으로 생각해야함
    for (int i = n - 1; i >= 1; --i) {
        // 로봇이 있다면
        if (belts[i].robot == 1) {
            // 다음 칸에 로봇이 없고 내구도가 0보다 크다면
            if (belts[i+1].robot == 0 && belts[i+1].d > 0) {
                belts[i].robot = 0; // 로봇이 이동했으니
                belts[i+1].robot = 1;
                belts[i+1].d --; // 내구도 감소
            }
        }
    }

    // 내리는 칸에 로봇이 있다면
    if (belts[n].robot == 1)
        belts[n].robot = 0;

    return;
}

// MARK: solution
int solution(int n, int k, Block *belts) {
    int answer = 0;
    // 문제 조건에 따라 시뮬레이션을 진행하여 내구도가 0인 칸의 개수가 K개 이상인 경우 종료 시켜여함
    // while문을 이용하고
    // 1. 탈출 조건 확인
    // 여기서 주의해야할께 벨트의 회전 방향이 ---> 이거였다 돌아올 때
    // <--- 이거라는 거임
    // 한칸씩 전진
    // 올리는 위치에 올리고 내리는 위치에 내릴수 있으면 내리고

    // 이걸 코드로 구현해야함

    while (1) {
        // 탈출 조건
        if (isBreak(n, k, belts)) {
            break;
        } else { // 벨트를 진행해야함
            // 먼저 벨트를 -> 방향으로 회전
            rotateBelts(n, k, belts);
            // 문제를 읽다보면 어떻게 거꾸로 회전하지 하지만
            // 그냥 하면 됌
            movingRobot(n, k, belts);
            // 이제 로봇을 올리고 내릴지 보기
            isAddingRobot(n, k, belts);

            answer++; // 시뮬레이션 카운트
        }
    }

    return answer;
}

// MARK: main
int main(int argc, const char * argv[]) {
    int n, k;
    Block belts[201];

    cin >> n >> k;
    for (int i = 1; i<= 2*n; ++i) {
        cin >> belts[i].d;
        belts[i].robot = 0;
    }

    int ret = solution(n, k , belts);
    cout << ret << "\n";
    return 0;
}

```
