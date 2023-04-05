//
//  main.cpp
//  BOJ20056
//
//  Created by KyungHeon Lee on 2023/04/04.
//

#include <iostream>
#include <vector>

using namespace std;

// MARK: 파이어볼의 정보
struct fireBall {
    int r,c,m,s,d;
};

int N,M,K;
vector<fireBall> fireBallV;
vector<fireBall> board[55][55];

const int dy[8] = {-1, -1, 0, 1, 1, 1, 0, -1};
const int dx[8] = {0, 1, 1, 1, 0, -1, -1, -1};

// MARK: 합쳐지는 파이어볼의 방향
int dirCheck(int y, int x) {
    int oddCnt = 0, evenCnt = 0;
    
    for (auto fb: board[y][x]) {
        if (fb.d%2 == 1) {
            oddCnt++;
        } else {
            evenCnt++;
        }
    }
    if ((oddCnt == board[y][x].size() && evenCnt == 0 )||
        (evenCnt == board[y][x].size() && oddCnt == 0)) {
        return 0;
    }
    return 1;
}

// MARK: 초기화
void fireBallinit(void) {
    for (int i = 1; i <= N; i++) {
        for (int j = 1; j <= N; j++) {
            board[i][j].clear();
        }
    }
    return;
}

// MARK: 1. 파이어볼 이동
void movingFireBall() {
    for (int i = 0; i < fireBallV.size(); ++i) {
        int y = fireBallV[i].r;
        int x = fireBallV[i].c;
        int mySpeed = fireBallV[i].s;
        int mydir = fireBallV[i].d;
        int myMess = fireBallV[i].m;
        
        
        // 방향 di로 속력 si칸 만큼 이동
        int move = mySpeed % N;
        int ny = y+(dy[mydir]*move);
        if (ny > N) ny -= N;
        if (ny < 1) ny += N;
        int nx = x+(dx[mydir]*move);
        if (nx < 1) nx += N;
        if (nx > N) nx -= N;
        
        // 격자판 업데이트
        board[ny][nx].push_back({ny, nx, myMess, mySpeed, mydir});
        fireBallV[i].r = ny;
        fireBallV[i].c = nx;
    }
    return;
}

// MARK: 2 문제 조건에 따른 파이어볼 업데이트
void updateFireBall(void) {
    // 2-1. 같은 칸에 있는 파이어볼은 모두 하나로 합쳐진다
//    2-2 파이어볼은 4개의 파이어볼로 나누어진다.
//    2-3 나누어진 파이어볼의 질량, 속력, 방향은 다음과 같다.
//    2-3-1 질량은 ⌊(합쳐진 파이어볼 질량의 합)/5⌋이다.
//    2-3-2 속력은 ⌊(합쳐진 파이어볼 속력의 합)/(합쳐진 파이어볼의 개수)⌋이다.
//    2-3-3합쳐지는 파이어볼의 방향이 모두 홀수이거나 모두 짝수이면, 방향은 0, 2, 4, 6이 되고, 그렇지 않으면 1, 3, 5, 7이 된다.
    
    // 2 이동이 모두 끝난 뒤, 2개 이상의 파이어볼이 있는 칸에서는 다음과 같은 일이 일어난다.
    vector<fireBall> tmp;
    
    for (int y = 1;  y <= N; ++y) {
        for (int x = 1; x <= N; ++x) {
            // 파이어볼 2개 이상 발견
            if (board[y][x].size() > 0) {
                if (board[y][x].size() == 1) {
                    tmp.push_back(board[y][x][0]);
                    continue;
                }
                
                int totMess = 0, totSpeed = 0;
                
                for (auto fb: board[y][x]) {
                    totMess += fb.m;
                    totSpeed += fb.s;
                }
                
                // 소멸
                if (totMess / 5 == 0) {
                    continue;
                }
                
                // 방향을 체크해야함
                // 1이면 홀수 0이면 짝수
                int flag = dirCheck(y, x);
                
                if (flag == 1) {
                    tmp.push_back({y,x,totMess/5, (int)(totSpeed / board[y][x].size()), 1});
                    tmp.push_back({y,x,totMess/5, (int)(totSpeed / board[y][x].size()), 3});
                    tmp.push_back({y,x,totMess/5, (int)(totSpeed / board[y][x].size()), 5});
                    tmp.push_back({y,x,totMess/5, (int)(totSpeed / board[y][x].size()), 7});
                } else {
                    tmp.push_back({y,x,totMess/5, (int)(totSpeed / board[y][x].size()), 0});
                    tmp.push_back({y,x,totMess/5, (int)(totSpeed / board[y][x].size()), 2});
                    tmp.push_back({y,x,totMess/5, (int)(totSpeed / board[y][x].size()), 4});
                    tmp.push_back({y,x,totMess/5, (int)(totSpeed / board[y][x].size()), 6});
                }
            }
        }
    }
    fireBallV = tmp;
    return;
}


// MARK: 풀이
int solution(void) {
    int answer = 0;
    
    // 마법사 상어가 모든 파이어볼에게 이동을 명령
    for (int i= 0; i < K; ++i) {
        // 격자판 셋팅
        fireBallinit();
        movingFireBall();
        updateFireBall();
    
    }
    
    
    // 파이어볼 질량의 합을 구함
    for(auto fb: fireBallV) {
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
        fireBallV.push_back({r,c,m,s,d});
    }
    
    int ret = solution();
    cout << ret;
    return 0;
}
