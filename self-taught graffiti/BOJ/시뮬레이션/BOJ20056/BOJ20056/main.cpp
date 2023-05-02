//
//  main.cpp
//  BOJ20056
//
//  Created by KyungHeon Lee on 2023/04/04.
//

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
