import Foundation

let photoNames = [ "Photo 1",  "Photo 2", "Photo 3"]

func listPhotos(inGallery name: String) async -> [String] {
    // 가짜 네트워크 지연
    try? await Task.sleep(nanoseconds: 500_000_000)
    return ["IMG_001", "IMG_002", "IMG_003", "IMG_004"]
}

func downloadPhoto(named name: String) async -> Data {
    // 랜덤 다운로드 시간
    let delay = UInt64.random(in: 500_000_000...1_500_000_000)
    try? await Task.sleep(nanoseconds: delay)
    return Data("Photo Data: \(name)".utf8)
}

func show(_ photo: Data) {
    print(String(data: photo, encoding: .utf8) ?? "")
}

await withTaskGroup(of: Data.self) { group in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        group.addTask {
            return await downloadPhoto(named: name)
        }
    }


    for await photo in group {
        show(photo)
    }
}

let photos = await withTaskGroup(of: Data.self) { group in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        group.addTask {
            return await downloadPhoto(named: name)
        }
    }

    var results: [Data] = []
    for await photo in group {
        results.append(photo)
    }

    return results
}

let photos2 = await withTaskGroup(of: Data?.self) { group in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        let added = group.addTaskUnlessCancelled {
            Task.isCancelled ? nil : await downloadPhoto(named: name)
        }
        guard added else { break }
    }

    var results: [Data] = []
    for await photo in group {
        if let photo { results.append(photo) }
    }
    return results
}

