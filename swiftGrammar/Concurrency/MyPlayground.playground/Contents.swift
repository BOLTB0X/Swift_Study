import Foundation

// MARK: - Completion Handler 기반 메서드
func listPhotos(inGallery name: String, completion: @escaping ([String]) -> Void) {
    print("'\(name)' 갤러리에서 사진 목록 가져오는 중...")
    DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
        completion(["IMG001", "IMG099", "IMG0404"])
    }
}

func downloadPhoto(named name: String, completion: @escaping (String) -> Void) {
    print("'\(name)' 다운로드 중...")
    DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
        completion("\(name) 데이터")
    }
}

func show(_ photo: String) {
    print("사진 표시: \(photo)")
}

// MARK: - 실행 예제
listPhotos(inGallery: "Summer Vacation") { photoNames in
    let sortedNames = photoNames.sorted()
    let name = sortedNames[0]
    
    downloadPhoto(named: name) { photo in
        show(photo)
    }
}
