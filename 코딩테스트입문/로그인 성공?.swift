import Foundation

func solution(_ id_pw:[String], _ db:[[String]]) -> String {
    // db를 하나씩 확인
    for d in db {
        // id가 같고
        if id_pw[0] == d[0] {
            // 비밀번호도 같다면
            if id_pw[1] == d[1] {
                return "login"
            } else { // 비밀번호가 다르다면
                return "wrong pw"
            }
        }
    }
    // 모두 다 다른 경우
    return "fail"
}