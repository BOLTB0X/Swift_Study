import Foundation

// MARK: - 메인 액터에서만 동작해야 하는 UI 관련 함수
@MainActor
func show(_ data: String) {
    print("UI에 사진 표시: \(data)")
}

// MARK: - 사진 다운로드
func downloadPhoto(named name: String) async -> String {
    print("사진 다운로드 시작: \(name)")
    try? await Task.sleep(nanoseconds: 1_000_000_000) // 1초 지연
    print("사진 다운로드 완료: \(name)")
    return "Photo(\(name))"
}

// MARK: - 메인 액터로 UI 업데이트
func downloadAndShowPhoto(named name: String) async {
    let photo = await downloadPhoto(named: name)
    await show(photo) // UI 업데이트는 메인 액터에서
}

// MARK: - @MainActor 타입 예시
@MainActor
struct PhotoGallery {
    var photoNames: [String]

    func drawUI() {
        print("UI 갱신: \(photoNames.joined(separator: ", "))")
    }
}

// MARK: - 부분적인 @MainActor 적용 예시
struct PhotoManager {
    @MainActor var photoNames: [String] = []
    var hasCachedPhotos = false

    @MainActor func drawUI() {
        print("UI 갱신: \(photoNames.joined(separator: ", "))")
    }

    mutating func cachePhotos() {
        print("사진 캐싱 작업 중... (UI 접근 없음)")
        self.hasCachedPhotos = true
    }
}

Task {
    await downloadAndShowPhoto(named: "Summer Vacation")

    let gallery = PhotoGallery(photoNames: ["IMG001", "IMG002"])
    gallery.drawUI()

    var manager = PhotoManager()
    await MainActor.run {
        manager.photoNames = ["IMG100", "IMG200"]
        manager.drawUI()
    }
    manager.cachePhotos()
}
