# 백준 > 삼성기출문제 > 14499 > 주사위 굴리기

## 문제

Gold 4
<br/>
문제링크 : https://www.acmicpc.net/problem/14499
문제설명, 제한사항 생략
<br/>

## Intro

주사위 신박하다
<br/>

## 풀이

주사위 굴러가는 것을 구현하는 게 핵심

> x 2 x
> <br/>
> 4 1 3
> <br/>
> x 5 x
> <br/>
> x 6 x

### 주사위 굴러가면

1. 동쪽

> x 2 x
> <br/>
> 6 4 1
> <br/>
> x 5 x
> <br/>
> x 3 x

```cpp
 // 동
if (dir == 1) {
    dice[1] = dice[4];
    dice[4] = dice[6];
    dice[6] = dice[3];
    dice[3] = tmp;
}
```

2. 서쪽

> x 2 x
> <br/>
> 1 3 6
> <br/>
> x 5 x
> <br/>
> x 4 x

```cpp
// 서
else if (dir == 2) {
	dice[1] = dice[3];
	dice[3] = dice[6];
	dice[6] = dice[4];
	dice[4] = tmp;
}
```

3. 남쪽

> x 6 x
> <br/>
> 4 2 3
> <br/>
> x 1 x
> <br/>
> x 5 x

```cpp
// 남
else if (dir == 3) {
	dice[1] = dice[2];
	dice[2] = dice[6];
	dice[6] = dice[5];
	dice[5] = tmp;
}
```

4. 북쪽

> x 1 x
> <br/>
> 4 5 3
> <br/>
> x 6 x
> <br/>
> x 2 x

```cpp
// 북
else if (dir == 4) {
	dice[1] = dice[5];
	dice[5] = dice[6];
	dice[6] = dice[2];
	dice[2] = tmp;
}
```

### 문제 조건에 되로 구현

> 지도의 각 칸에는 정수가 하나씩 쓰여져 있다. 주사위를 굴렸을 때,
> <br/>
> 이동한 칸에 쓰여 있는 수가 0이면, 주사위의 바닥면에 쓰여 있는 수가 칸에 복사된다.
> <br/>
> 0이 아닌 경우에는 칸에 쓰여 있는 수가 주사위의 바닥면으로 복사되며, 칸에 쓰여 있는 수는 0이 된다

이는 굴러가서 board의 숫자가 없으면 주사위 상단, 아니면 반대로 진행하면 됌

```cpp
// 이동한 주사위 상단을 보드에 붙여줌
if (board[nx][ny] == 0) {
    board[nx][ny] = dice[6];
} else { // 보드의 값을 주사위에 붙여줌
    dice[6] = board[nx][ny];
    board[nx][ny] = 0;
}
```

그런 다음 마지막에 주사위 위치만 잘 바꿔주면 해결할 수 있는 문제
<br/>

```cpp
// 주사위 위치 교체
cy = ny;
cx = nx;
```

## 최종 코드

```cpp
//
//  main.cpp
//  BOJ14499
//
//  Created by KyungHeon Lee on 2023/04/08.
//

#include <iostream>
#include <vector>

using namespace std;

int N,M,K;
int board[21][21];
int dice[7]; // 주사위
int diceY, diceX; // 첫 주사위 위치

vector<int> cmdV; // 명령을 담을 벡터
vector<int> answer; // 정답 벡터

// 동 서 남 북
const int dx[5] = { 0,0,0,-1,1 };
const int dy[5] = { 0,1,-1,0,0 };


// MARK: 범위 판단
int inRange(int x, int y) {
    return y >= 0 && x >= 0 && x < N && y < M;
}

// MARK: 주사위 굴리기
void rollingDice(int dir) {
    int tmp = dice[1];

    // 동
    if (dir == 1) {
        dice[1] = dice[4];
        dice[4] = dice[6];
        dice[6] = dice[3];
        dice[3] = tmp;
    }
    // 서
    else if (dir == 2) {
        dice[1] = dice[3];
        dice[3] = dice[6];
        dice[6] = dice[4];
        dice[4] = tmp;
    }

    // 남
    else if (dir == 3) {
        dice[1] = dice[2];
        dice[2] = dice[6];
        dice[6] = dice[5];
        dice[5] = tmp;
    }

    // 북
    else if (dir == 4) {
        dice[1] = dice[5];
        dice[5] = dice[6];
        dice[6] = dice[2];
        dice[2] = tmp;
    }

    return;
}

// MARK: 풀이
void solution(void) {
    // 현재 주사위 위치
    int cy = diceY, cx = diceX;

    // 명령을 순차적으로 진행
    for (auto c: cmdV) {
        int ny = cy + dy[c];
        int nx = cx + dx[c];

        // 굴리기 가능한지 확인
        if (inRange(nx, ny) == 0)
            continue;

        // 주사위 굴리기
        rollingDice(c);

        // 이동한 주사위 상단을 보드에 붙여줌
        if (board[nx][ny] == 0) {
            board[nx][ny] = dice[6];
        } else { // 보드의 값을 주사위에 붙여줌
            dice[6] = board[nx][ny];
            board[nx][ny] = 0;
        }

        answer.push_back(dice[1]);
        // 주사위 위치 교체
        cy = ny;
        cx = nx;
    }

    return;
}

// MARK: 메인
int main(int argc, const char * argv[]) {
    cin >> N >> M >> diceX >> diceY >> K;

    //  동쪽은 1, 서쪽은 2, 북쪽은 3, 남쪽은 4로 주어진다.
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < M; ++j) {
            cin >> board[i][j];
        }
    }

    cmdV = vector<int>(K);
    for (int i = 0; i < K; ++i) {
        cin >> cmdV[i];
    }

    solution();

    for (auto ans: answer) {
        cout << ans << "\n";
    }
    return 0;
}
```
