import Foundation

// MARK: - Modèles de base du jeu

class Player {
    let name: String
    var wins = 0
    var totalScore = 0
    
    init(name: String) {
        self.name = name
    }
    
    var rank: String {
        if totalScore < 100 {
            return "Débutant"
        } else if totalScore < 300 {
            return "Challenger"
        } else if totalScore < 600 {
            return "Expert"
        } else if totalScore < 1000 {
            return "Maître"
        } else {
            return "Grand Maître"
        }
    }
}

enum CellState {
    case empty
    case player
    case opponent
    
    var display: String {
        switch self {
        case .empty: return "⚪"
        case .player: return "🔴"
        case .opponent: return "🔵"
        }
    }
    
    var displayPlain: String {
        switch self {
        case .empty: return "O"
        case .player: return "X"
        case .opponent: return "0"
        }
    }
} 