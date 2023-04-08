# 백준 > 삼성기출문제 > 21608 > 상어 초등학교

## 문제

Gold 5
<br/>
문제링크 : https://www.acmicpc.net/problem/21608
문제설명, 제한사항 생략
<br/>

## Intro

깐깐한 구현 조건중 문제에 잘 설명되어있지 않은 부분을 생각해야하는 문제
<br/>

이젠 상어가 초등학교를?
<br/>

## 풀이

### data 정의

제일먼저 생각했던 건 구조체를 어떻게 할까였음
<br/>

문제에선 좋아하는 학생들이 얼마나 인접해 있냐와 빈자리, r,c의 거리를 요구하면서 입력(input)은 다르게 받는다는 것을 확인
<br/>

그렇다면 귀찮더라도 구조체를 두개를 나눔

```cpp
struct Student {
    int studentID;
    int love1;
    int love2;
    int love3;
    int love4;
};

struct Sitting {
    int y,x;
    int loveCnt, blankCnt;
};
```

<br/>

이를 활용하여 벡터로 표현하면

```cpp
vector<Student> studentV; // 학생들을 담아줄 벡터
vector<Sitting> sV; // 문제조건에 따라 정렬해줄 벡터
```

<br/>

### 문제조건의 정렬

> 비어있는 칸 중에서 좋아하는 학생이 인접한 칸에 가장 많은 칸으로 자리를 정한다.
> <br/>
> 1을 만족하는 칸이 여러 개이면, 인접한 칸 중에서 비어있는 칸이 가장 많은 칸으로 자리를 정한다.
> <br/>
> 2를 만족하는 칸도 여러 개인 경우에는 행의 번호가 가장 작은 칸으로, 그러한 칸도 여러 개이면 열의 번호가 가장 작은 칸으로 자리를 정한다.
> <br/>

그래서 생각한 것은 학생들의 자리를 정해줄 때 **_각 조건을 따지고 후보들은 벡터넣은 것_**
<br/>

후보군 탐색이 끝나면 정렬조건을 변경한 compare을 이용

```cpp
// MARK: 정렬 조건 변경
bool compare(Sitting A, Sitting B) {
    if (A.loveCnt == B.loveCnt) {
        if (A.blankCnt == B.blankCnt) {
            if (A.y == B.y) {
                return A.x < B.x;
            }
            return A.y < B.y;
        }
        return A.blankCnt > B.blankCnt;
    }
    return A.loveCnt > B.loveCnt;
}
```

1. 최상위 함수
   정말 심플하게 두가지 함수를 실행하면 해결할 수 있음
   <br/>
   첫번째로 for문으로 한 학생씩 빈자리, 선호 학생을 검사
   <br/>
   두번째로 만족도 검사
   <br/>

   ```cpp
   // MARK: 풀이
   int solution(void) {
    // 심플하게
    // 자리 선정
    // 만족도 검사
    settingSit();

    return getScore();
    }
   ```

2. 자리 배정 (완전탐색)
   학생을 하나씩 뽑아놓고 이때 정렬용 벡터를 생성하며 조건을 따진뒤 넣고 격자판에 표시를 하면 됌
   <br/>

   이를 코드로 순차적으로 작성하면
   <br/>

   ```cpp
   // MARK: 자리 배정
   void settingSit(void) {
    // 순서대로 학생들 자리배성
    for (auto st: studentV) {
        vector<Sitting> sV; // 문제조건에 따라 정렬해줄 벡터

        for (int i = 1; i<=N; ++i) {
            for (int j = 1; j<=N; ++j) {
                // 자리 배정이 된 것 발견
                if (board[i][j] != 0) {
                    continue;
                }

                // 빈자리이니 문제 조건 하나씩 구현
                int totLove =0, totBlank = 0;
                for (int dir = 0; dir <4; ++dir) {
                    int ny = i + dy[dir];
                    int nx = j + dx[dir];

                    // 범위 초과
                    if (ny < 1 || nx < 1 || ny > N || nx > N)
                        continue;

                    // 좋아하는 학생이 인접한 칸에 가장 많은 칸
                    if (board[ny][nx] == st.love1 || board[ny][nx] == st.love2 ||
                        board[ny][nx] == st.love3 || board[ny][nx] == st.love4) {
                        totLove++;
                    }

                    // 인접한 칸 중에서 비어있는 칸
                    else if (board[ny][nx] == 0) {
                        totBlank++;
                    }
                }

                // 대기석에 넣어줌
                sV.push_back({i,j,totLove, totBlank});
            }
        }

        // 자리 배치 후보군을 탐색 후
        // 대기석에 원소들이 많다면
        if (sV.size() > 0) {
            sort(sV.begin(), sV.end(), compare);
        }
        // 대기석 벡터의 최상단을 현재 학생의 번호를 넣어줌
        board[sV[0].y][sV[0].x] = st.studentID;
    }
    return;
    }
   ```

   <br/>

   여기서 주의할 점은 인접을 판단하는 기준임
   <br/>

   > |r1 - r2| + |c1 - c2| = 1을 만족하는 두 칸이 (r1, c1)과 (r2, c2)를 인접하다고 한다.
   > <br/>

   ```cpp
   // 상하좌우
   const int dy[4] = {-1,1,0,0};
   const int dx[4] = {0,0,-1,1};
   ```

   즉 상하좌우란 뜻
   <br/>

3. 만족도 검사

   > 학생의 만족도를 구하려면 그 학생과 인접한 칸에 앉은 좋아하는 학생의 수를 구해야 한다.
   > <br/>
   > 그 값이 0이면 학생의 만족도는 0, 1이면 1, 2이면 10, 3이면 100, 4이면 1000이다.
   > <br/>

   저 위 자리 배정과 동일하게 순차적으로 학생들을 for문으로 돌리며 인접학생들을 카운트하고 저 점수조건에 맞춰주면 됌
   <br/>

   - 만족도 점수 조건
     <br/>
     ```cpp
     // 만족도
     const int happy[5] = {0,1,10,100,1000};
     ```
   - 학생의 만족도 계산
     자리 배정과 비슷하게
     <br/>

     ```cpp
     // MARK: 만족도 검사
     int getScore(void) {
        int res = 0;

        for (auto st: studentV) {
            // 현재 학생 좌표반환
            pair<int,int> ret = findPos(st.studentID);
            int satisfy = 0;
            // 만족도 검사를 위해 인접학생 찾기
            for (int dir = 0; dir <4; ++dir) {
                int ny = ret.first + dy[dir];
                int nx = ret.second + dx[dir];

                // 범위 초과
                if (ny < 1 || nx < 1 || ny > N || nx > N)
                    continue;

                // 좋아하는 학생이 인접한 칸에 가장 많은 칸
                if (board[ny][nx] == st.love1 || board[ny][nx] == st.love2 ||
                    board[ny][nx] == st.love3 || board[ny][nx] == st.love4) {
                    satisfy++;
                }
            }

            res += happy[satisfy];
        }

        return res;
     }
     ```

       <br/>

     여기서 주의할 점은 학생백터로는 저 학생이 어디 좌표에 있는 지 모름 그러므로 함수를 하나 만들어줌
     <br/>

     ```cpp
     // MARK: 좌표 반환
     pair<int,int> findPos(int Id) {
       for (int i = 1; i <=N; ++i) {
           for (int j = 1; j<=N; ++j) {
               if (board[i][j] == Id) {
                   return {i, j};
               }
           }
       }
     return {0, 0};
     }
     ```

     <br/>

이제 위 순서대로 작성하면 문제를 해결할 수 있음
<br/>

## 최종코드

```cpp
#include <iostream>
#include <vector>
#include <algorithm> // sort

using namespace std;

/// 문제조건
/// 1. 비어있는 칸 중에서 좋아하는 학생이 인접한 칸에 가장 많은 칸으로 자리를 정한다.
/// 2. 1을 만족하는 칸이 여러 개이면, 인접한 칸 중에서 비어있는 칸이 가장 많은 칸으로 자리를 정한다.
/// 3. 2를 만족하는 칸도 여러 개인 경우에는 행의 번호가 가장 작은 칸으로, 그러한 칸도 여러 개이면 열의 번호가 가장 작은 칸으로 자리를 정한다.
/// 학생의 만족도를 구하려면 그 학생과 인접한 칸에 앉은 좋아하는 학생의 수를 구해야 한다. 그 값이 0이면 학생의 만족도는 0, 1이면 1, 2이면 10, 3이면 100, 4이면 1000이다.
/// 정렬조건을 할 cmp가 중요

// MARK: data 정의
struct Student {
    int studentID;
    int love1;
    int love2;
    int love3;
    int love4;
};

struct Sitting {
    int y,x;
    int loveCnt, blankCnt;
};

// MARK: 정렬 조건 변경
bool compare(Sitting A, Sitting B) {
    if (A.loveCnt == B.loveCnt) {
        if (A.blankCnt == B.blankCnt) {
            if (A.y == B.y) {
                return A.x < B.x;
            }
            return A.y < B.y;
        }
        return A.blankCnt > B.blankCnt;
    }
    return A.loveCnt > B.loveCnt;
}

int N;
int board[21][21];
// 상하좌우
const int dy[4] = {-1,1,0,0};
const int dx[4] = {0,0,-1,1};
// 만족도
const int happy[5] = {0,1,10,100,1000};
// 학생벡터
vector<Student> studentV;

// MARK: 자리 배정
void settingSit(void) {
    // 순서대로 학생들 자리배성
    for (auto st: studentV) {
        vector<Sitting> sV; // 문제조건에 따라 정렬해줄 벡터

        for (int i = 1; i<=N; ++i) {
            for (int j = 1; j<=N; ++j) {
                // 자리 배정이 된 것 발견
                if (board[i][j] != 0) {
                    continue;
                }

                // 빈자리이니 문제 조건 하나씩 구현
                int totLove =0, totBlank = 0;
                for (int dir = 0; dir <4; ++dir) {
                    int ny = i + dy[dir];
                    int nx = j + dx[dir];

                    // 범위 초과
                    if (ny < 1 || nx < 1 || ny > N || nx > N)
                        continue;

                    // 좋아하는 학생이 인접한 칸에 가장 많은 칸
                    if (board[ny][nx] == st.love1 || board[ny][nx] == st.love2 ||
                        board[ny][nx] == st.love3 || board[ny][nx] == st.love4) {
                        totLove++;
                    }

                    // 인접한 칸 중에서 비어있는 칸
                    else if (board[ny][nx] == 0) {
                        totBlank++;
                    }
                }

                // 대기석에 넣어줌
                sV.push_back({i,j,totLove, totBlank});
            }
        }

        // 자리 배치 후보군을 탐색 후
        // 대기석에 원소들이 많다면
        if (sV.size() > 0) {
            sort(sV.begin(), sV.end(), compare);
        }
        // 대기석 벡터의 최상단을 현재 학생의 번호를 넣어줌
        board[sV[0].y][sV[0].x] = st.studentID;
    }
    return;
}

// MARK: 좌표 반환
pair<int,int> findPos(int Id) {
    for (int i = 1; i <=N; ++i) {
        for (int j = 1; j<=N; ++j) {
            if (board[i][j] == Id) {
                return {i, j};
            }
        }
    }

    return {0, 0};
}

// MARK: 만족도 검사
int getScore(void) {
    int res = 0;

    for (auto st: studentV) {
        // 현재 학생 좌표반환
        pair<int,int> ret = findPos(st.studentID);
        int satisfy = 0;
        // 만족도 검사를 위해 인접학생 찾기
        for (int dir = 0; dir <4; ++dir) {
            int ny = ret.first + dy[dir];
            int nx = ret.second + dx[dir];

            // 범위 초과
            if (ny < 1 || nx < 1 || ny > N || nx > N)
                continue;

            // 좋아하는 학생이 인접한 칸에 가장 많은 칸
            if (board[ny][nx] == st.love1 || board[ny][nx] == st.love2 ||
                board[ny][nx] == st.love3 || board[ny][nx] == st.love4) {
                satisfy++;
            }
        }

        res += happy[satisfy];
    }

    return res;
}

// MARK: 풀이
int solution(void) {
    // 심플하게
    // 자리 선정
    // 만족도 검사
    settingSit();

    return getScore();
}

// MARK: 메인
int main(int argc, const char * argv[]) {

    cin >> N;
    for (int i= 0; i < N*N; ++i) {
        int n, l1,l2,l3,l4;

        cin >> n >> l1 >> l2 >> l3 >> l4;
        studentV.push_back({n, l1, l2, l3, l4});
    }

    cout << solution();
    return 0;
}

```

## 참고

https://4z7l.github.io/2021/04/29/algorithms-boj-21608.html
<br/>
https://wooono.tistory.com/597
<br/>
