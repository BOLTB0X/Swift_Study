import Foundation
import Combine

print("1")
DispatchQueue.main.async {
    print("슈우우우우우ㅜ우우웅1")

}
print("2")
DispatchQueue.main.async {
    print("슈우우우우우ㅜ우우웅2")

}
print("3")

DispatchQueue.main.async {
    print("슈우우우우우ㅜ우우웅3")
}

///task들을 순차적으로 처리하며, 한 번에 1개의 task 만 처리하는 DispatchQueue
//1
//2
//3
//슈우우우우우ㅜ우우웅1
//슈우우우우우ㅜ우우웅2
//슈우우우우우ㅜ우우웅3

DispatchQueue.global().async {
    // 백그라운드 작업
    // 이 부분에서 특정 무거운 Task를 주로 함
    
    DispatchQueue.main.async {
        // 메인 스레드에서 UI 업데이트
    }
}

func fetchData() async throws -> Data {
    let url = URL(string: "https://github.com/BOLTB0X")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
}

Task {
    do {
        let data = try await fetchData()
        print("Data: \(data)")
    } catch {
        print("Error: \(error)")
    }
}
