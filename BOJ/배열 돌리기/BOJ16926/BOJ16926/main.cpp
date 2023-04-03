//
//  main.cpp
//  BOJ16926
//
//  Created by KyungHeon Lee on 2023/04/04.
//

#include <iostream>
#include <algorithm>

using namespace std;

int board[301][301];

void solution(int n, int m, int r) {
    int backup[301][301];
    
    // 시계 반대 방향으로 요소를 1칸씩 이동시키며, 이를 R번 반복
    while (r--) {
        for (int i = 0; i < min(n,m)/2; ++i) {
            int x1 = i, y1 = i, x2 = n-1-i, y2= m-1-i;
            
            // 좌 <-
            for (int j=y2-1;j>=y1; --j) {
                backup[x1][j] = board[x1][j+1];
            }
            
            // 하
            for (int j=x1+1;j<=x2;++j) {
                backup[j][y1] = board[j-1][y1];
            }
            
            // 우 ->
            for (int j=y1+1; j<=y2; ++j) {
                backup[x2][j] = board[x2][j-1];
            }
            
            // 상
            for (int j=x2-1; j>= x1; --j) {
                backup[j][y2] = board[j+1][y2];
            }
        }
        
        // 맵 복사
        for(int i = 0; i < n; i++) {
            for(int j = 0; j < m; j++) {
                board[i][j] = backup[i][j];
            }
        }
    }
    
    return;
}

int main(int argc, const char * argv[]) {
    int n, m, r;
    
    cin >> n >> m >> r;
    
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < m; ++j) {
            cin >> board[i][j];
        }
    }
    
    solution(n, m, r);
    
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < m; ++j) {
            cout << board[i][j] << " ";
        }
        cout << "\n";
    }
    
    return 0;
}
