func solution(_ n:Int, _ arr1:[Int], _ arr2:[Int]) -> [String] {
    // 클로저로 풀어봄
    // zip으로 둘을 묶어주고
    // 비트연산 
    // 그 후 앞에 0 조심
    var answer = zip(arr1, arr2).map { data -> String in
        let str = String(UInt16(data.0) | UInt16(data.1), radix: 2)
        return str.count < n ? String(repeating: "0", count: n - str.count) + str : str
    }
    // 마지막 # 처리
    return answer.map {$0.reduce("") { $1 == "1" ? $0+"#" : $0+" "}}
}