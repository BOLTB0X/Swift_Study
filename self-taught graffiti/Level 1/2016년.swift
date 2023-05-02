func solution(_ a:Int, _ b:Int) -> String {
    // 1월 1일이 금요일이므로
    // 하지만 인덱스가 0이므로 한칸씩 뒤로 미룸
    var day: [String] = ["THU", "FRI", "SAT", "SUN", "MON", "TUE", "WED"]
    var totalDays: Int = 0 // 총 일수
    
    // 2016년은 윤년
    // 1월부터 a전까지까지 더해줌
    for i in 1..<a {
        switch i {
        case 1, 3, 5, 7, 8, 10, 12 :
            totalDays += 31
        case 2:
            totalDays += 29
        default:
            totalDays += 30
        }
    }
    // 이번 달 일수 더해줌
    totalDays += b
        
    return day[(totalDays%7)]
}