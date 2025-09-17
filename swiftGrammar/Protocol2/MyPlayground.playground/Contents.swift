import Foundation

// 난수 생성기
class LinearCongruentialGenerator {
    private var lastRandom = 42.0
    private let m = 139968.0
    private let a = 3877.0
    private let c = 29573.0
    
    func random() -> Double {
        lastRandom = (lastRandom * a + c).truncatingRemainder(dividingBy: m)
        return lastRandom / m
    }
}

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

let tracker = DiceGameTracker()
let game = DiceGame(sides: 6)

game.delegate = tracker
game.play(rounds: 3)

//Started a new game
//Player 2 won round 1
//Player 2 won round 2
//Player 1 won round 3
//Player 2 won!


extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}


let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]

print(equalNumbers.allEqual())      // true
print(differentNumbers.allEqual())  // false
