# 2. Protocol (Delegation / Protocol Conformance)

> Define requirements that conforming types must implement.

> 특정 작업이나 기능에 적합한 메서드, 프로퍼티 및 기타 요구 사항의 청사진을 정의함

---

## Delegation (위임 패턴)

<details>
<summary> contents </summary>

> 어떤 클래스(또는 구조체)가 자기 책임의 일부를 다른 타입의 인스턴스에게 위임(delegate) 하는 디자인 패턴

- **Swift** 에서는 **Protocol** 을 정의해서 `delegate` 가 구현해야 할 메서드를 명시

- **Delegate** 를 `weak` 참조로 선언 -> **강한 순환 참조(Strong Reference Cycle)** 방지

- 흔히 UIKit, SwiftUI, Foundation 등에서 쓰는 패턴 (ex: `UITableViewDelegate`, `UITextFieldDelegate`)

---

*ex. 주사위 게임과 게임의 진행사항을 관찰하는 위임에 대한 중첩된 프로토콜을 정의*


```swift
// DiceGame 클래스
class DiceGame {
    let sides: Int
    let generator = LinearCongruentialGenerator()
    weak var delegate: Delegate?
    
    init(sides: Int) {
        self.sides = sides
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
    
    func play(rounds: Int) {
        delegate?.gameDidStart(self)
        
        for round in 1...rounds {
            let player1 = roll()
            let player2 = roll()
            
            if player1 == player2 {
                delegate?.game(self, didEndRound: round, winner: nil)
            } else if player1 > player2 {
                delegate?.game(self, didEndRound: round, winner: 1)
            } else {
                delegate?.game(self, didEndRound: round, winner: 2)
            }
        }
        
        delegate?.gameDidEnd(self)
    }
    
    // Delegate 프로토콜 정의
    protocol Delegate: AnyObject {
        func gameDidStart(_ game: DiceGame)
        func game(_ game: DiceGame, didEndRound round: Int, winner: Int?)
        func gameDidEnd(_ game: DiceGame)
    }
}
```

- `DiceGame.Delegate` 프로토콜은 주사위 게임의 진행사항을 추적하기 위해 채택될 수 있음

- `DiceGame.Delegate` 프로토콜은 주사위 게임의 컨텍스트에서만 사용되기 때문에, DiceGame 클래스 내에 중첩됌, 프로토콜은 외부 선언이 **제너릭** 하지 않으면, **구조체와 클래스와 같은 타입 선언 내에 중첩될 수 있음**

- 강한 참조 사이클을 방지하기 위해 위임자는 약한 참조로 선언

- `delegate` 프로퍼티는 옵셔널 `DiceGame.Delegate` 이므로 `play(rounds:)` 메서드는 위임에 대한 메서드를 호출할 때마다 옵셔널 체이닝을 사용

- `delegate` 프로퍼티가 `nil` 이면 이 위임자 호출은 무시됌

- `delegate` 프로퍼티가 `nil` 이 아니면 이 위임자 메서드가 호출되고 파라미터로 `DiceGame` 인스턴스는 전달

```swift
// 게임 진행을 추적하는 Tracker
class DiceGameTracker: DiceGame.Delegate {
    var playerScore1 = 0
    var playerScore2 = 0
    
    func gameDidStart(_ game: DiceGame) {
        print("Started a new game")
        playerScore1 = 0
        playerScore2 = 0
    }
    
    func game(_ game: DiceGame, didEndRound round: Int, winner: Int?) {
        switch winner {
        case 1:
            playerScore1 += 1
            print("Player 1 won round \(round)")
        case 2:
            playerScore2 += 1
            print("Player 2 won round \(round)")
        default:
            print("The round was a draw")
        }
    }
    
    func gameDidEnd(_ game: DiceGame) {
        if playerScore1 == playerScore2 {
            print("The game ended in a draw.")
        } else if playerScore1 > playerScore2 {
            print("Player 1 won!")
        } else {
            print("Player 2 won!")
        }
    }
}
```

- `diceGameTracker` 클래스는 `DiceGame.Delegate` 프로토콜에 의해 요구되는 3개 메서드를 모두 구현

- 이 세 메서드를 이용해서 새로운 게임이 시작되면 플레이어의 점수를 모두 0으로 만들고, 각 라운드가 끝날 때마다 점수를 업데이트하고, 게임이 끝나면 승리자를 발표

```swift
let tracker = DiceGameTracker()
let game = DiceGame(sides: 6)

game.delegate = tracker
game.play(rounds: 3)

//Started a new game
//Player 2 won round 1
//Player 2 won round 2
//Player 1 won round 3
//Player 2 won!
```

</details>

---

## 확장으로 프로토콜 준수성 추가 (Adding Protocol Conformance with an Extension)

<details>
<summary> contents </summary>

</details>