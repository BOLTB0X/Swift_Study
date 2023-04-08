//
//  main.cpp
//  BOJ21608
//
//  Created by KyungHeon Lee on 2023/04/07.
//

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
