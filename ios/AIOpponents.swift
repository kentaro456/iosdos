import Foundation

// MARK: - Modèle pour les adversaires IA

class AIOpponent: Player {
    let level: Int
    let description: String
    let introText: String
    let winText: String
    let loseText: String
    
    // Paramètres de l'IA
    let lookahead: Int       // Nombre de coups d'avance à analyser
    let centerPreference: Int // Préférence pour les colonnes centrales (1-10)
    let aggressivity: Int     // Tendance à bloquer l'adversaire vs jouer offensivement (1-10)
    let randomness: Int       // Facteur aléatoire dans les décisions (1-10, 10 = très aléatoire)
    
    init(name: String, level: Int, description: String, introText: String, winText: String, loseText: String, 
         lookahead: Int, centerPreference: Int, aggressivity: Int, randomness: Int) {
        self.level = level
        self.description = description
        self.introText = introText
        self.winText = winText
        self.loseText = loseText
        self.lookahead = lookahead
        self.centerPreference = centerPreference
        self.aggressivity = aggressivity
        self.randomness = randomness
        super.init(name: name)
    }
    
    func chooseMove(in game: ConnectFourGame) -> Int {
        // Nous allons simplement renvoyer un coup aléatoire ou basé sur un algorithme simple
        // sans dépendre des méthodes privées du jeu
        
        // On suppose qu'il y a 7 colonnes (0-6)
        let columns = 7
        
        // Colonnes avec priorité basée sur la préférence du centre
        let columnsByPriority: [Int]
        
        if centerPreference >= 8 {
            // Haute préférence pour le centre
            columnsByPriority = [3, 2, 4, 1, 5, 0, 6]
        } else if centerPreference >= 5 {
            // Préférence moyenne pour le centre
            columnsByPriority = [3, 2, 4, 1, 5, 0, 6]
        } else {
            // Préférence faible, plus aléatoire
            columnsByPriority = [3, 2, 4, 0, 6, 1, 5]
        }
        
        // Facteur aléatoire
        if randomness >= 8 {
            // Très aléatoire
            return Int.random(in: 0..<columns)
        }
        
        // Essayer les colonnes par ordre de priorité
        for col in columnsByPriority {
            // Note: C'est au jeu de rejeter les coups invalides
            return col
        }
        
        // Fallback sur une colonne aléatoire
        return Int.random(in: 0..<columns)
    }
} 