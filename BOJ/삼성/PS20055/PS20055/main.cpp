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
