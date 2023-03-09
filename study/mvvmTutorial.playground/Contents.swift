import PlaygroundSupport
import UIKit

// Mark: - Model
// 모델 정의
public class Pet {
    public enum Rarity {
        case common
        case uncommon
        case rare
        case veryRare
    }
    
    public let name: String
    public let birthday: Date
    public let rarity: Rarity
    public let image: UIImage
    
    public init(name: String,
                birthday: Date,
                rarity: Rarity,
                image:UIImage) {
        self.name = name
        self.birthday = birthday
        self.rarity = rarity
        self.image = image
    }
}

// MARK: - ViewModel
public class PetViewModel {
    // 2개의 private 프로퍼티를 생성, init
    private let pet: Pet
    private let calendar: Calendar
    
    public init(pet: Pet) {
        self.pet = pet
        self.calendar = Calendaår(identifier: .gregorian)
    }
    
    // cf.
    // computed propertie: 다른 속성을 기반으로 속성 값이 결정
    // Stored Property은 값을 저장할 메모리 공간 O
    // Computed Property는 메모리 공간 X
    
    // 연산 프로퍼티 2개 선언
    // 만약 개발도중 모든 애완 동물의 이름에 접두사를 추가하도록 디자인을 변경하려는 경우 여기에서 이름을 수정하여 쉽게 변경 가능
    public var name: String {
        return pet.name
    }
    
    public var image: UIImage {
        return pet.image
    }
    
    // 약간 다른 연산 프로퍼티 선언
    // 여기에서 Calendar를 이용하여 오늘 시작일과 애완동물의 생일 사이의 연도 차이를 계산하고 "연령"이 뒤에 오는 문자열로 반환하는 프로퍼티를 선언해줌
    // 다른 문자열 형식을 수행하지 않고도 이 값을 뷰에 직접 표시 가능
    public var ageText: String {
        let today = calendar.startOfDay(for: Date())
        let birthday = calendar.startOfDay(for: pet.birthday)
        let components = calendar.dateComponents([.year], from: birthday, to: today)
        
        let age = components.year!
        return "\(age) years old"
    }
    
    // 희귀도에 따라 애완 동물의 입양 비용을 결정하는 연산 프로퍼티
    // 이것을 직접 표시할 수 있도록 문자열로 반환
    public var adoptionFeeText: String {
        switch pet.rarity {
            case .common:
                return "$50.00"
            case .uncommon:
                return "$75.00"
            case .rare:
                return "$150.00"
            case .veryRare:
                return "$500.00"
        }
    }
}

// MARK: - View
public class PetView: UIView {
    public let imageView: UIImageView // 이미지 view
    public let nameLabel: UILabel // 이름 label
    public let ageLabel: UILabel // 나이 label
    public let adoptionFeeLabel: UILabel // 입양비 label
    
    public override init(frame: CGRect) {
        var childFrame = CGRect(x:0, y:16, width: frame.width,height: frame.height/2)
        
        imageView = UIImageView(frame: childFrame)
        imageView.contentMode = .scaleAspectFit
        
        childFrame.origin.y += childFrame.height+10
        childFrame.size.height = 30
        nameLabel = UILabel(frame: childFrame)
        nameLabel.textAlignment = .center
        
        childFrame.origin.y += childFrame.height
        ageLabel = UILabel(frame: childFrame)
        ageLabel.textAlignment = .center
        
        childFrame.origin.y += childFrame.height
        adoptionFeeLabel = UILabel(frame: childFrame)
        adoptionFeeLabel.textAlignment = .center
        
        super.init(frame: frame)
        
        backgroundColor = .white
        // 4개의 하위 view
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(ageLabel)
        addSubview(adoptionFeeLabel)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init?(coder:) is not supported")
    }
}

// MARK: - Example
let birthday = Date(timeIntervalSinceNow: (-2*86400*360))
let image = UIImage(named: "stuart")!
let stuart = Pet(name: "Stuart",
                birthday: birthday,
                rarity: .veryRare,
                image: image)

let viewModel = PetViewModel(pet: stuart)

let frame = CGRect(x: 0, y: 0, width: 300, height: 420)
let view = PetView(frame: frame)

view.nameLabel.text = viewModel.name
view.imageView.image = viewModel.image
view.ageLabel.text = viewModel.ageText
view.adoptionFeeLabel.text = viewModel.adoptionFeeText

PlaygroundPage.current.liveView = view
