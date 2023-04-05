//
//  main.cpp
//  BOJ21610
//
//  Created by KyungHeon Lee on 2023/04/05.
//

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
