import Foundation

func solution(_ N:Int, _ stages:[Int]) -> [Int] {
    var answer:[Int] = [] // 정답
    // 인덱스-> 스테이지, 값 진행자 수
    var stageFail = Array(repeating: 0, count: N+2) 
    var stageSuccess = Array(repeating: 0, count: N+2)
    // 인덱스 를 key로 이용할 실패율 딕셔너리 선언
    var failPercents = [Int:Double]()
    
    // 진행자들 카운팅
    for i in 0..<stages.count {
        stageFail[stages[i]] += 1
    }
    
    var tmp:Int = stages.count // 총 인원
    for i in 1..<N+2 {
        // 총인원에 현재 스테이지 진행자를 빼줌
        stageSuccess[i] = tmp - stageFail[i]
        tmp -= stageFail[i] // 인원 빼줌
    }
    
    // 실패율 계산
    for i in 1..<N+1 {
        // 실수형으로 계산해줌
        let Per = Double(stageFail[i]) / Double(stageSuccess[i])
    failPercents[i] = Per
    }
    
    // 문제 조건상 실패율 기준 내림차순으로 인덱스를 정답으로 반환해줘야함
    // 그러므로 배열에 넣기 전 sorted로 정렬해 줌
    
    // 임시 배열 생성
    // 값이 같으면 인덱스, value로 내림차순 진행
    let tmpFailPercents = failPercents.sorted(by : <).sorted(by: { $0.1 > $1.1})
    
    // key를 값으로 같는 배열로 만들어줌
    answer = tmpFailPercents.map{ $0.key}
    
    return answer
}