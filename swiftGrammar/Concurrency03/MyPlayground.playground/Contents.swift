import Foundation

let handle = FileHandle.standardInput
for try await line in handle.bytes.lines {
    print(line)
}

func show(_ photos: [String]) {
    for photo in photos {
        print("🖼️ \(photo)")
    }
}

let photoNames = [ "Photo 1",  "Photo 2", "Photo 3"]

func downloadPhoto(named name: String) async -> String {
    let delay = UInt64.random(in: 1_000_000_000...3_000_000_000) // 1~3초
    try? await Task.sleep(nanoseconds: delay)
    return "\(name)"
}

func sequentialDownload() async {
    let start = Date()
    
    let firstPhoto = await downloadPhoto(named: photoNames[0])
    let secondPhoto = await downloadPhoto(named: photoNames[1])
    let thirdPhoto = await downloadPhoto(named: photoNames[2])
    
    let end = Date()
    print("순차 실행 결과: \(firstPhoto), \(secondPhoto), \(thirdPhoto)")
    print("걸린 시간: \(end.timeIntervalSince(start))초\n")
}

// 병렬 실행 (async let)
func parallelDownload() async {
    let start = Date()
    
    async let firstPhoto = downloadPhoto(named: photoNames[0])
    async let secondPhoto = downloadPhoto(named: photoNames[1])
    async let thirdPhoto = downloadPhoto(named: photoNames[2])
    
    let photos = await [firstPhoto, secondPhoto, thirdPhoto]
    
    let end = Date()
    print("병렬 실행 결과: \(photos.joined(separator: ", "))")
    print("걸린 시간: \(end.timeIntervalSince(start))초\n")
}

// Playground 실행
Task {
    print("=== 순차 실행 ===")
    await sequentialDownload()
    
    print("=== 병렬 실행 ===")
    await parallelDownload()
}


async let firstPhoto = downloadPhoto(named: photoNames[0])
async let secondPhoto = downloadPhoto(named: photoNames[1])
async let thirdPhoto = downloadPhoto(named: photoNames[2])

let photos = await [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
