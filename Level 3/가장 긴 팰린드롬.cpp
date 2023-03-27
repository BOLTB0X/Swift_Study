#include <iostream>
#include <string>

using namespace std;

int solution(string s) {
    int answer = 1;
    int size = s.length();
    
    while(size >= 2) {
        for (int i = 0; i <= s.length() - size; ++i) {
            int left = i, right = size + i - 1;
            bool flag = true;
            while(left <= right) {
                if (s[left++] != s[right--]) {
                    flag = false;
                    break;
                }
            }
            if (flag)
                return size;
        }
        size--;
    }
    
    return answer;
}