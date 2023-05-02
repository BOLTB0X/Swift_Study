# 백준 > 삼성기출문제 > 20055 > 마법사 상어와 비바라기

## 문제

Gold 5
<br/>
문제링크 : https://www.acmicpc.net/problem/21610
문제설명, 제한사항 생략
<br/>

## Intro

깐깐한 구현 조건을 생각해야하는 문제
<br/>

이젠 상어가 별걸 다 배우네
<br/>

## 풀이

비바리기 구름의 이동 후 격자판의 변화를 코드로 깐깐하게 구현하는 문제
<br/>

문제흐름을 한 번 놓치고 손으로만 코딩하면 실수가 생기는 문제이기도 한 것같음
<br/>

문제 설명에서 주목해야할 포인트들은
<br/>

1. 격자판의 의미

   > (r, c)는 격자의 r행 c열에 있는 바구니를 의미하고, A[r][c]는 (r, c)에 있는 바구니에 저장되어 있는 물의 양
   > <br/>

   즉 격자판에 boara[r][c]의 값이 물의 양
   <br/>

2. 공간을 지배하는 상어

   > 격자의 가장 왼쪽 윗 칸은 (1, 1)이고, 가장 오른쪽 아랫 칸은 (N, N)이다. 마법사 상어는 연습을 위해 1번 행과 N번 행을 연결했고, 1번 열과 N번 열도 연결했다.
   > <br/>
   > 즉, N번 행의 아래에는 1번 행이, 1번 행의 위에는 N번 행이 있고, 1번 열의 왼쪽에는 N번 열이, N번 열의 오른쪽에는 1번 열이 있다.
   > <br/>

   기존 시뮬레이션 문제에서 격자판 범위를 넘어가면 그냥 넘겼으면 이 문제에선 1보다 작으면 가장자리로 격자판 크기보다 커지면 최상단으로
   <br/>

```cpp
// MARK: 범위 체크
int rangeCheck(int pos) {
    if (pos < 0)
        return N-1;
    if (pos >= N)
        return 0;
    return pos;
}
```

3. 이동방향

   > 1부터 순서대로 ←, ↖, ↑, ↗, →, ↘, ↓, ↙ 이다.
   > <br/>

   입력이 1~8로 들어오는 것을 조심
   <br/>

```cpp
const int dy[9] = {0, 0, -1, -1, -1, 0, 1, 1, 1};
const int dx[9] = {0, -1, -1, 0, 1, 1, 1, 0, -1};
```

4. 구름의 이동
   4.1 구름의 표현

   > 비바라기를 시전하면 (N, 1), (N, 2), (N-1, 1), (N-1, 2)에 비구름이 생긴다.
   > <br/>

   이를 벡터로 표현하면 됌

   ```cpp
   vector<pair<int, int>> cloud;
   ```

   4.2 구름의 이동

   > 모든 구름이 di 방향으로 si칸 이동한다.
   > <br/>

   ```cpp
    // MARK: 1. 구름의 이동
    // 모든 구름이 di 방향으로 si칸 이동한다.
    void movingCloud(int dir, int move) {
        memset(cloudBoard, 0, sizeof(cloudBoard));

        // 구름의 위치를 하나씩 이동시킴
        for (int i = 0; i < cloud.size(); ++i) {
            int cy = cloud[i].first, cx = cloud[i].second;
            int ny = cy, nx = cx;

            // 이동
            for (int j = 0; j < move; ++j) {
                ny += dy[dir];
                ny = rangeCheck(ny); // 범위체크 조심
                nx += dx[dir];
                nx = rangeCheck(nx); // 범위체크 조심
            }

            // 구름 위치 변경
            cloud[i].first = ny;
            cloud[i].second = nx;
        }

        // 현재 구름 위치 체크
        for (int i = 0; i < cloud.size(); ++i) {
            cloudBoard[cloud[i].first][cloud[i].second] = 1;
        }

        return;
    }
   ```

   4.3 문제 조건 (2~3)

   > 각 구름에서 비가 내려 구름이 있는 칸의 바구니에 저장된 물의 양이 1 증가한다.
   > <br/>
   > 구름이 모두 사라진다.
   > <br/>

   ```cpp
    // MARK: 2. 물의증가
    void waterIncrease(void) {
        for (int i = 0; i < N; ++i) {
            for (int j = 0; j < N; ++j) {
                if (cloudBoard[i][j] == 1) {
                    A[i][j] += 1;
                }
            }
        }

        return;
    }

    for (auto mp: movingPlan) {
        // 1
        // 2
        // 3 구름이 모두 사라진다.
        cloud.clear();
        // 4
        // 5
    }
   ```

   4.4 문제 조건 (4)

   > 물이 증가한 칸 (r, c)에 물복사버그 마법을 시전한다. 물복사버그 마법을 사용하면, 대각선 방향으로 거리가 1인 칸에 물이 있는 바구니의 수만큼 (r, c)에 있는 바구니의 물이 양이 증가한다.
   > <br/>
   > 이때는 이동과 다르게 경계를 넘어가는 칸은 대각선 방향으로 거리가 1인 칸이 아니다.
   > <br/>
   > 예를 들어, (N, 2)에서 인접한 대각선 칸은 (N-1, 1), (N-1, 3)이고, (N, N)에서 인접한 대각선 칸은 (N-1, N-1)뿐이다.
   > <br/>

   ```cpp
    // MARK: 4. 물복사 버그
    void waterBug(void) {
    // 이때는 이동과 다르게 경계를 넘어가는 칸은 대각선 방향으로 거리가 1인 칸이 아니다.
    // 예를 들어, (N, 2)에서 인접한 대각선 칸은 (N-1, 1), (N-1, 3)이고, (N, N)에서 인접한 대각선 칸은 (N-1, N-1)뿐이다.
    // 이거 조심

        for (int i = 0; i < N; ++i) {
            for (int j = 0; j < N; ++j) {
                // 대각선 체크
                if (cloudBoard[i][j] == 1) {
                    int cnt = 0;
                    // 2씩 땡기면 됌
                    for (int dir = 2; dir <= 8; dir += 2) {
                        int ny = i + dy[dir];
                        int nx = j + dx[dir];

                        // 범위 초과
                        if (ny < 0 || nx < 0 || ny >= N || nx >= N)
                            continue;

                        if (A[ny][nx] > 0) {
                            cnt++;
                        }
                    }

                    // 물 복사
                    A[i][j] += cnt;
                }
            }
        }

        return;
    }
   ```

   4.5 문제 조건 (5)

   > 바구니에 저장된 물의 양이 2 이상인 모든 칸에 구름이 생기고, 물의 양이 2 줄어든다.
   > <br/>
   > 이때 구름이 생기는 칸은 3에서 구름이 사라진 칸이 아니어야 한다.
   > <br/>

   ```cpp
    // MARK: 5 구름 생성
    void createCloud(void) {
        for (int i = 0; i < N; ++i) {
            for (int j = 0; j < N; ++j) {
                // 바구니에 저장된 물의 양이 2 이상인 모든 칸에 구름이 생기고, 물의 양이 2 줄어든다. 이때 구름이 생기는 칸은 3에서 구름이 사라진 칸이 아니어야 한다.
                // 기존것과 구분을 위해 0인 것만
                if (cloudBoard[i][j] == 0 && A[i][j] >= 2) {
                    A[i][j] -= 2;
                    cloudBoard[i][j] = 1; // 구름 생성

                    // 구름벡터에도 넣어줌
                    cloud.push_back({i,j});
                }
            }
        }

        return;
    }
   ```

이를 순차적으로 코드를 작성하면 해결할 수 있음
<br/>

## 최종코드

```cpp
#include <iostream>
#include <vector>
#include <cstring>

using namespace std;

const int dy[9] = {0, 0, -1, -1, -1, 0, 1, 1, 1};
const int dx[9] = {0, -1, -1, 0, 1, 1, 1, 0, -1};

int N,M;
int A[55][55];
int cloudBoard[55][55];
vector<pair<int, int>> movingPlan;
vector<pair<int, int>> cloud;

void printV() {
    for (int i = 0; i < cloud.size(); ++i) {
        cout << cloud[i].first << " " << cloud[i].second << "\n";
    }
}

void printd() {
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            cout << cloudBoard[i][j] << " ";
        }
        cout << "\n";
    }
}

// MARK: 범위 체크
int rangeCheck(int pos) {
    if (pos < 0)
        return N-1;
    if (pos >= N)
        return 0;
    return pos;
}

// MARK: 1. 구름의 이동
// 모든 구름이 di 방향으로 si칸 이동한다.
void movingCloud(int dir, int move) {
    memset(cloudBoard, 0, sizeof(cloudBoard));

    // 구름의 위치를 하나씩 이동시킴
    for (int i = 0; i < cloud.size(); ++i) {
        int cy = cloud[i].first, cx = cloud[i].second;
        int ny = cy, nx = cx;

        // 이동
        for (int j = 0; j < move; ++j) {
            ny += dy[dir];
            ny = rangeCheck(ny);
            nx += dx[dir];
            nx = rangeCheck(nx);
        }

        // 구름 위치 변경
        cloud[i].first = ny;
        cloud[i].second = nx;
    }

    // 현재 구름 위치 체크
    for (int i = 0; i < cloud.size(); ++i) {
        cloudBoard[cloud[i].first][cloud[i].second] = 1;
    }

    return;
}

// MARK: 2. 물의증가
void waterIncrease(void) {
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            if (cloudBoard[i][j] == 1) {
                A[i][j] += 1;
            }
        }
    }

    return;
}

// MARK: 4. 물복사 버그
void waterBug(void) {
//    이때는 이동과 다르게 경계를 넘어가는 칸은 대각선 방향으로 거리가 1인 칸이 아니다.
//    예를 들어, (N, 2)에서 인접한 대각선 칸은 (N-1, 1), (N-1, 3)이고, (N, N)에서 인접한 대각선 칸은 (N-1, N-1)뿐이다.
    // 이거 조심

    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            // 대각선 체크
            if (cloudBoard[i][j] == 1) {
                int cnt = 0;
                // 2씩 땡기면 됌
                for (int dir = 2; dir <= 8; dir += 2) {
                    int ny = i + dy[dir];
                    int nx = j + dx[dir];

                    // 범위 초과
                    if (ny < 0 || nx < 0 || ny >= N || nx >= N)
                        continue;

                    if (A[ny][nx] > 0) {
                        cnt++;
                    }
                }

                // 물 복사
                A[i][j] += cnt;
            }
        }
    }

    return;
}

// MARK: 5 구름 생성
void createCloud(void) {
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            // 바구니에 저장된 물의 양이 2 이상인 모든 칸에 구름이 생기고, 물의 양이 2 줄어든다. 이때 구름이 생기는 칸은 3에서 구름이 사라진 칸이 아니어야 한다.
            if (cloudBoard[i][j] == 0 && A[i][j] >= 2) {
                A[i][j] -= 2;
                cloudBoard[i][j] = 1; // 구름 생성

                // 구름벡터에도 넣어줌
                cloud.push_back({i,j});
            }
        }
    }

    return;
}

// MARK: 풀이
int solution(void) {
    int answer = 0;

    cloud.push_back({N-2, 0});
    cloud.push_back({N-2, 1});
    cloud.push_back({N-1, 0});
    cloud.push_back({N-1, 1});

    for (auto mp: movingPlan) {
        // 1
        movingCloud(mp.first, mp.second);
        // 2
        waterIncrease();
        // 3 구름이 모두 사라진다.
        cloud.clear();
        // 4
        waterBug();
        // 5
        createCloud();
    }

    // 계산
    for (int i = 0; i <N; ++i) {
        for (int j=0; j <N; ++j) {
            answer += A[i][j];
        }
    }

    return answer;
}

// MARK: main
int main(int argc, const char * argv[]) {
    // MARK: 입력
    cin >> N >> M;
    // N X N 맵 입력
    for (int i = 0; i <N; ++i) {
        for (int j = 0; j<N; ++j) {
            cin >> A[i][j];
        }
    }

    // 이동 스탭
    for (int i = 0; i < M; ++i) {
        int d, s;

        cin >> d >> s;
        movingPlan.push_back({d, s});
    }

    int ret = solution();
    cout << ret;
    return 0;
}

```
