import Foundation

// MARK: - 비동기 함수 예제

func listPhotos(inGallery name: String) async -> [String] {
    print("'\(name)' 갤러리에서 사진 목록 가져오는 중...")
    try? await Task.sleep(nanoseconds: 1_000_000_000) // 1초 대기
    return ["IMG001", "IMG099", "IMG0404"]
}

func downloadPhoto(named name: String) async -> String {
    print("'\(name)' 다운로드 중...")
    try? await Task.sleep(nanoseconds: 500_000_000) // 0.5초 대기
    return "\(name) 데이터"
}

func show(_ photo: String) {
    print("사진 표시: \(photo)")
}


Task {
    // 사진 목록 가져오기
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    let sortedNames = photoNames.sorted()
    let firstName = sortedNames[0]

    // 첫 번째 사진 다운로드 후 표시
    let photo = await downloadPhoto(named: firstName)
    show(photo)
}

func riskyFunction() throws -> Int {
    return Int.random(in: 0...1) == 0 ? 42 : try { throw NSError(domain: "Fail", code: 1) }()
}

func safeWrapper() -> Result<Int, Error> {
    return Result {
        try riskyFunction()
    }
}

print(safeWrapper())

func asyncFunction() async -> Int {
    return 42
}

func syncFunction() {
    //let value = asyncFunction() // 에러
}
