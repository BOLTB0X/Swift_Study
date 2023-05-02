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
