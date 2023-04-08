# 백준 > 삼성기출문제 > 20055 > 마법사 상어와 파이어볼

## 문제

Gold 4
<br/>
문제링크 : https://www.acmicpc.net/problem/20056
문제설명, 제한사항 생략
<br/>

## Intro

깐깐한 구현 조건중 문제에 잘 설명되어있지 않은 부분을 생각해야하는 문제
<br/>

이젠 상어가 불 마법까지 다 배우네
<br/>

## 풀이

파이어볼을 대기석같으 곳에 넣어 두고 K번 시뮬레이션으로 이동 후 남은 질량들을 구하는 문제
<br/>

- 들어가기전 체크해야할 부분

  > 7 0 1
  > <br/>
  > 6 x 2
  > <br/>
  > 5 4 3
  > <br/>

  이는 빙향으로 나타내면

  ```cpp
  const int dy[8] = {-1, -1, 0, 1, 1, 1, 0, -1};
  const int dx[8] = {0, 1, 1, 1, 0, -1, -1, -1};
  ```

---

정말 순차적으로 생각해보면 (코드의 주석을 읽으면서 따라가보자)
<br/>

### 시뮬레이션

제일 먼저 시뮬레이션을 돌릴 최상위 함수는
<br/>

```cpp
// MARK: 플이
int solution(void) {
    int answer = 0;

    /// 1. 문제조건을 보면 파이어볼을 이동
    /// 2. 파이어볼 업데이트
    /// 3. 총 질량 구하기

    // 1 ~ 2
    while(K--) {
        // 이동을 K번 명령한 후
        // 1
        for (auto fb: fireBallV) {
            moving(fb.r, fb.c, fb.m, fb.s, fb.d);
        }
        // board 업데이트
        // 2
        updateFireBall();
    }
    // 3
    for (auto fb: fireBallV) {
        answer += fb.m;
    }
    return answer;
}
```

### 파이어볼의 이동

> 모든 파이어볼이 자신의 방향 di로 속력 si칸 만큼 이동한다.
> <br/>
> 이동하는 중에는 같은 칸에 여러 개의 파이어볼이 있을 수도 있다.
> <br/>

1. 자신의 방향과 속력만큼 이동한다는 뜻은 -> **\_그 뱡항 곱하기 (속력%격자판)\_**

   ```cpp
   int move = 속력%격자판의 길이;
   int 이동된 좌표 = 현재+(방향배열[방향]*move);
   ```

   <br/>

2. 한 칸에 여러개 존재는 -> **_이를 넣어주기 위해 격자판을 NXN벡터로_**

   ```cpp
   vector<FireBall> board[51][51];


   // 생략

   // 격자판에 표시
   board[ny][nx].push_back({ny, nx, m, s, d});
   ```

   <br/>

이를 코드로 나타내면

```cpp
// MARK: 파이어볼 이동
void moving(int y, int x, int m, int s, int d) {

    int move = s%N;

    int ny = y+(dy[d]*move);
    // 범위 체크
    if (ny > N) ny -= N;
    else if (ny < 1) ny += N;

    int nx = x+(dx[d]*move);
    // 범위 체크
    if (nx > N) nx -= N;
    else if (nx < 1) nx += N;

    // 격자판에 표시
    board[ny][nx].push_back({ny, nx, m, s, d});
}
```

### 격자판 위의 파이어볼 업데이트

1. 같은 칸에 있는 파이어볼은 모두 하나로 합쳐진다.(문제 조건 2-1)

   하나인 경우와 2개 이상인 경우로 나눔
   <br/>

   - 하나인 경우

   ```cpp
    if (board[i][j].size() == 1) {
        fireBallV.push_back({i, j, board[i][j][0].m, board[i][j][0].s, board[i][j][0].d});
        continue; // 이제 할 게 없으니 넘어가 버리자
    }
   ```

   <br/>

   - 2개 이상인 경우

   ```cpp
    for (auto fb: board[i][j]) {
        totMess += fb.m;
        totSpeed += fb.s;
    }
   ```

   <br/>

2. 합친 파이어볼을 4등분하고 문제조건에 맞춰 새롭게 넣어주기(문제조건 2-2 ~ 2-4)

- 4등분 된 뉴 파이어볼 방향 결정하기

  > 합쳐지는 파이어볼의 방향이 모두 홀수이거나 모두 짝수이면, 방향은 0, 2, 4, 6이 되고, 그렇지 않으면 1, 3, 5, 7이 된다.
  > <br/>

  이를 정말 숨어있는 의미를 파악하는 것이 아닌 그대로 코드로 구현하면

  ```cpp
  // MARK: 2-3-3 문제조건
  int checkDir(int y, int x) {
    int Even = 0, Odd = 0;

    for (auto fb: board[y][x]) {
        if (fb.d % 2) {
            Odd = 1;
        } else {
            Even = 1;
        }
    }

    if ((Odd == 1 && Even == 0) || (Odd == 0 && Even == 1)) {
        return 0;
    }
    return 1;
  }
  ```

       <br/>

  > 나누어진 파이어볼의 질량, 속력, 방향은 다음과 같다.
  > <br/>
  > 질량은 ⌊(합쳐진 파이어볼 질량의 합)/5⌋이다.
  > <br/>
  > 속력은 ⌊(합쳐진 파이어볼 속력의 합)/(합쳐진 파이어볼의 개수)⌋이다.
  > <br/>
  > 중략
  > <br/>
  > 질량이 0인 파이어볼은 소멸되어 없어진다.
  > <br/>

  이를 순차적으로 코드로 구현하면

  ```cpp
  // MARK: 조건에 의한 격자판 업데이트
  void updateFireBall(void) {
    // 새로운 파이어볼 벡터를 위해
    fireBallV.clear();

    for (int i =1; i<=N; ++i) {
        for (int j=1; j<=N;++j) {
            // 파이어볼 발견
            if (board[i][j].size() > 0) {
                // 하나인 경우
                if (board[i][j].size() == 1) {
                    fireBallV.push_back({i, j, board[i][j][0].m, board[i][j][0].s, board[i][j][0].d});
                    continue;
                } else { // 2개 이상
                    int totMess = 0;
                    int totSpeed = 0;

                    for (auto fb: board[i][j]) {
                        totMess += fb.m;
                        totSpeed += fb.s;
                    }

                    // 파이어볼 소멸
                    if (totMess / 5 <= 0)
                        continue;

                    int flag = checkDir(i, j);

                    if (flag == 0) {
                        fireBallV.push_back({i,j, totMess/5, (int)(totSpeed/board[i][j].size()), 0});
                        fireBallV.push_back({i,j, totMess/5, (int)(totSpeed/board[i][j].size()), 2});
                        fireBallV.push_back({i,j, totMess/5, (int)(totSpeed/board[i][j].size()), 4});
                        fireBallV.push_back({i,j, totMess/5, (int)(totSpeed/board[i][j].size()), 6});
                    } else {
                        fireBallV.push_back({i,j, totMess/5, (int)(totSpeed/board[i][j].size()), 1});
                        fireBallV.push_back({i,j, totMess/5, (int)(totSpeed/board[i][j].size()), 3});
                        fireBallV.push_back({i,j, totMess/5, (int)(totSpeed/board[i][j].size()), 5});
                        fireBallV.push_back({i,j, totMess/5, (int)(totSpeed/board[i][j].size()), 7});
                    }
                }
            }
        }
    }

    // 보드 초기화
    for (int i =1; i<=N; ++i) {
        for (int j=1; j<=N;++j) {
            board[i][j].clear();
        }
    }
  }
  ```

  <br/>

## 최종코드

```cpp
#include <iostream>
#include <vector>

using namespace std;

struct FireBall {
    int r,c,m,s,d;
};

int N,M,K;
const int dy[8] = {-1, -1, 0, 1, 1, 1, 0, -1};
const int dx[8] = {0, 1, 1, 1, 0, -1, -1, -1};

vector<FireBall> fireBallV;
vector<FireBall> board[51][51];

// MARK: 2-3-3 문제조건
int checkDir(int y, int x) {
    int Even = 0, Odd = 0;

    for (auto fb: board[y][x]) {
        if (fb.d % 2) {
            Odd = 1;
        } else {
            Even = 1;
        }
    }

    if ((Odd == 1 && Even == 0) || (Odd == 0 && Even == 1)) {
        return 0;
    }
    return 1;
}

// MARK: 조건에 의한 격자판 업데이트
void updateFireBall(void) {
    // 새로운 파이어볼 벡터를 위해
    fireBallV.clear();

    for (int i =1; i<=N; ++i) {
        for (int j=1; j<=N;++j) {
            // 파이어볼 발견
            if (board[i][j].size() > 0) {
                // 하나인 경우
                if (board[i][j].size() == 1) {
                    fireBallV.push_back({i, j, board[i][j][0].m, board[i][j][0].s, board[i][j][0].d});
                    continue;
                } else { // 2개 이상
                    int totMess = 0;
                    int totSpeed = 0;

                    for (auto fb: board[i][j]) {
                        totMess += fb.m;
                        totSpeed += fb.s;
                    }

                    // 파이어볼 소멸
                    if (totMess / 5 <= 0)
                        continue;

                    int flag = checkDir(i, j);

                    if (flag == 0) {
                        fireBallV.push_back({i,j, totMess/5, (int)(totSpeed/board[i][j].size()), 0});
                        fireBallV.push_back({i,j, totMess/5, (int)(totSpeed/board[i][j].size()), 2});
                        fireBallV.push_back({i,j, totMess/5, (int)(totSpeed/board[i][j].size()), 4});
                        fireBallV.push_back({i,j, totMess/5, (int)(totSpeed/board[i][j].size()), 6});
                    } else {
                        fireBallV.push_back({i,j, totMess/5, (int)(totSpeed/board[i][j].size()), 1});
                        fireBallV.push_back({i,j, totMess/5, (int)(totSpeed/board[i][j].size()), 3});
                        fireBallV.push_back({i,j, totMess/5, (int)(totSpeed/board[i][j].size()), 5});
                        fireBallV.push_back({i,j, totMess/5, (int)(totSpeed/board[i][j].size()), 7});
                    }
                }
            }
        }
    }

    // 보드 초기화
    for (int i =1; i<=N; ++i) {
        for (int j=1; j<=N;++j) {
            board[i][j].clear();
        }
    }
}

// MARK: 파이어볼 이동
void moving(int y, int x, int m, int s, int d) {

    int move = s%N;

    int ny = y+(dy[d]*move);
    // 범위 체크
    if (ny > N) ny -= N;
    else if (ny < 1) ny += N;

    int nx = x+(dx[d]*move);
    // 범위 체크
    if (nx > N) nx -= N;
    else if (nx < 1) nx += N;

    // 격자판에 표시
    board[ny][nx].push_back({ny, nx, m, s, d});
}

// MARK: 플이
int solution(void) {
    int answer = 0;

    /// 1. 문제조건을 보면 파이어볼을 이동
    /// 2. 파이어볼 업데이트
    /// 3. 총 질량 구하기

    // 1 ~ 2
    while(K--) {
        // 이동을 K번 명령한 후
        // 1
        for (auto fb: fireBallV) {
            moving(fb.r, fb.c, fb.m, fb.s, fb.d);
        }
        // board 업데이트
        // 2
        updateFireBall();
    }
    // 3
    for (auto fb: fireBallV) {
        answer += fb.m;
    }
    return answer;
}

// MARK: main
int main(int argc, const char * argv[]) {
    cin >> N >> M >> K;

    for (int i = 0; i < M; ++i) {
        int r,c,m,s,d;

        cin >> r >> c >> m >> s >> d;
        fireBallV.push_back({r, c, m, s, d});
    }

    cout << solution();

    return 0;
}
```

## 참고

https://yabmoons.tistory.com/600
<br/>
https://youbin-shin.github.io/posts/sp-baekjoon-20056/
<br/>
