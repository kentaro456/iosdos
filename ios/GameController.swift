import Foundation

// MARK: - Contrôleur de jeu

// Classe principale qui gère le flux du jeu
class GameController {
    private var player: Player!
    private var skipNarration: Bool = false // Option pour sauter la narration
    private var skipLostGame: Bool = false // Option pour sauter une partie perdue
    private var difficulty: Int = 2 // Difficulté par défaut (1: Facile, 2: Normal, 3: Difficile)
    
    // Variables pour suivre les choix du joueur dans le manoir
    private var lastRoomChoice: Int = 0
    private var lastActionChoice: Int = 0
    
    // Liste des adversaires IA avec leurs caractéristiques
    private var opponents: [AIOpponent] = [
        AIOpponent(
            name: "Le Gardien du Hall", 
            level: 1, 
            description: "Un serviteur fantomatique qui garde l'entrée du manoir.", 
            introText: "Bienvenue au Manoir des Quatre Piliers. Pour progresser, vous devrez me battre!", 
            winText: "Vous n'êtes pas de taille face aux mystères de ce manoir.", 
            loseText: "Impressionnant! Le hall est à vous, mais le manoir recèle bien d'autres dangers.",
            lookahead: 0,
            centerPreference: 1,
            aggressivity: 1,
            randomness: 10
        ),
        AIOpponent(
            name: "La Gouvernante", 
            level: 2, 
            description: "Une dame austère qui contrôle l'aile est du manoir.", 
            introText: "Nul ne passe cette aile sans mon consentement. Prouvez votre valeur!", 
            winText: "La stratégie n'est visiblement pas votre fort.", 
            loseText: "Vous avez de l'intuition. L'aile est est maintenant ouverte pour vous.",
            lookahead: 1,
            centerPreference: 3,
            aggressivity: 3,
            randomness: 7
        ),
        AIOpponent(
            name: "Le Majordome", 
            level: 3, 
            description: "Un homme élégant mais inquiétant qui règne sur l'aile ouest.", 
            introText: "L'aile ouest renferme bien des secrets. Saurez-vous les mériter?", 
            winText: "Votre défaite était prévisible. Retournez sur vos pas.", 
            loseText: "Vous avez su anticiper mes mouvements. Continuez votre exploration.",
            lookahead: 2,
            centerPreference: 5,
            aggressivity: 6,
            randomness: 4
        ),
        AIOpponent(
            name: "L'Alchimiste", 
            level: 4, 
            description: "Un savant fou qui a fait du grenier son laboratoire.", 
            introText: "Mon laboratoire n'est pas un lieu pour les novices. Montrez-moi votre génie!", 
            winText: "Votre esprit est trop simple pour comprendre mes formules de victoire.", 
            loseText: "Fascinant! Votre esprit est vif. Les étages supérieurs vous sont ouverts.",
            lookahead: 3,
            centerPreference: 8,
            aggressivity: 7,
            randomness: 2
        ),
        AIOpponent(
            name: "Le Propriétaire", 
            level: 5, 
            description: "Le maître mystérieux du manoir, reclus dans les souterrains.", 
            introText: "Peu ont atteint ces profondeurs. Votre périple s'achève ici.", 
            winText: "Vous resterez prisonnier de ce manoir pour l'éternité!", 
            loseText: "Extraordinaire! Vous êtes le premier à me vaincre. La sortie est vôtre.",
            lookahead: 4,
            centerPreference: 9,
            aggressivity: 9,
            randomness: 1
        )
    ]
    
    // Fonction pour démarrer le jeu
    func startGame() {
        TerminalUI.clearScreen()
        
        // Afficher le menu principal avec l'option Options
        let mainMenu = ["Nouvelle Partie", "Options", "Quitter"]
        
        var running = true
        while running {
            // Utiliser le titre du jeu ici
            let choice = TerminalUI.displayMenu(title: "LE MANOIR DES 4 PILIERS", options: mainMenu)
            
            switch choice {
            case 0: // Nouvelle Partie
                startNewGame()
            case 1: // Options
                showOptions()
            case 2: // Quitter
                running = false
                TerminalUI.clearScreen()
                TerminalUI.displayAnimation(text: "Merci d'avoir joué au Manoir des 4 Piliers!")
            default:
                break
            }
        }
    }
    
    // Fonction pour afficher et gérer les options du jeu
    private func showOptions() {
        TerminalUI.clearScreen()
        
        // Menu des options avec la nouvelle option
        let optionsMenu = [
            "Difficulté: \(getDifficultyName())", 
            "Narration: \(skipNarration ? "Désactivée" : "Activée")", 
            "Sauter parties perdues: \(skipLostGame ? "Activé" : "Désactivé")",
            "Retour"
        ]
        
        var inOptionsMenu = true
        while inOptionsMenu {
            let choice = TerminalUI.displayMenu(title: "OPTIONS", options: optionsMenu)
            
            switch choice {
            case 0: // Changer la difficulté
                changeDifficulty()
                // Mettre à jour l'affichage du menu
                return showOptions()
            case 1: // Activer/désactiver la narration
                skipNarration = !skipNarration
                // Mettre à jour l'affichage du menu
                return showOptions()
            case 2: // Activer/désactiver l'option de sauter les parties perdues
                skipLostGame = !skipLostGame
                // Mettre à jour l'affichage du menu
                return showOptions()
            case 3: // Retour
                inOptionsMenu = false
            default:
                break
            }
        }
    }
    
    // Fonction pour changer la difficulté du jeu
    private func changeDifficulty() {
        TerminalUI.clearScreen()
        
        let difficulties = ["Facile", "Normal", "Difficile"]
        let choice = TerminalUI.displayMenu(title: "CHOISIR LA DIFFICULTÉ", options: difficulties)
        
        // Ajuster la difficulté (1-3)
        difficulty = choice + 1
    }
    
    // Fonction pour obtenir le nom de la difficulté actuelle
    private func getDifficultyName() -> String {
        switch difficulty {
        case 1: return "Facile"
        case 2: return "Normal"
        case 3: return "Difficile"
        default: return "Normal"
        }
    }
    
    // Fonction pour démarrer une nouvelle partie
    private func startNewGame() {
        // Choisir la difficulté avant de commencer
        let difficultyMenu = ["Facile", "Normal", "Difficile"]
        let choice = TerminalUI.displayMenu(title: "CHOISISSEZ VOTRE NIVEAU DE DIFFICULTÉ", options: difficultyMenu)
        difficulty = choice + 1
        
        // Choisir d'activer ou désactiver la narration
        let narrationMenu = ["Afficher l'histoire", "Sauter l'histoire"]
        let narrationChoice = TerminalUI.displayMenu(title: "PRÉFÉRENCE DE NARRATION", options: narrationMenu)
        skipNarration = narrationChoice == 1
        
        // Choisir d'activer ou désactiver l'option de sauter les parties perdues
        let skipLostGameMenu = ["Jouer toutes les parties", "Pouvoir sauter après une défaite"]
        let skipLostGameChoice = TerminalUI.displayMenu(title: "OPTION DE PARTIE", options: skipLostGameMenu)
        skipLostGame = skipLostGameChoice == 1
        
        // Afficher le prologue au début (sauf si skipNarration est activé)
        if !skipNarration {
            Prologue.displayPrologue()
        }
        
        var playerName = ""
        while playerName.isEmpty {
            playerName = TerminalUI.getInput(prompt: "Entrez votre nom, visiteur du manoir:", color: .yellow)
            if playerName.isEmpty {
                print(TerminalUI.colorText("Le nom ne peut pas être vide.", color: .red))
            }
        }
        
        player = Player(name: playerName)
        
        TerminalUI.displayFramedText([
            TerminalUI.colorText("Bienvenue, \(playerName)!", color: .bold),
            "",
            "Vous voici piégé dans le Manoir des Quatre Piliers!",
            "Pour retrouver votre liberté, vous devrez vaincre chaque gardien au jeu de Puissance 4.",
            "Difficulté: \(getDifficultyName())",
            "Que votre stratégie et vos choix vous guident vers la sortie!"
        ], frameColor: .cyan)
        
        TerminalUI.waitForEnter()
        
        // Sélectionner les adversaires en fonction de la difficulté
        var selectedOpponents: [AIOpponent] = []
        
        switch difficulty {
        case 1: // Facile - 3 adversaires (niveaux 1-3)
            selectedOpponents = Array(opponents.prefix(3))
        case 2: // Normal - 4 adversaires (niveaux 1-4)
            selectedOpponents = Array(opponents.prefix(4))
        case 3: // Difficile - 5 adversaires (tous)
            selectedOpponents = opponents
        default:
            selectedOpponents = Array(opponents.prefix(4))
        }
        
        // Lancer l'exploration du manoir avec les adversaires sélectionnés
        startMansionExploration(with: selectedOpponents)
    }
    
    // Fonction pour démarrer l'exploration du manoir
    private func startMansionExploration(with mansionGuardians: [AIOpponent]) {
        var currentRoom = 1
        var mansionCompleted = false
        
        // Réinitialiser les variables de suivi des salles et énigmes
        StoryEvents.lastRoomChoice = 0
        StoryEvents.lastActionChoice = 0
        StoryEvents.enigmaSuccess = false
        StoryEvents.enigmaScoreEffect = 0
        
        for guardian in mansionGuardians {
            TerminalUI.clearScreen()
            TerminalUI.displayFramedText([
                TerminalUI.colorText("SALLE \(currentRoom): \(guardian.name)", color: .bold),
                "",
                guardian.description,
                "",
                "Pour passer cette salle, vous devez vaincre le gardien au Puissance 4.",
                "Ce duel se joue au meilleur des trois parties.",
                guardian.level > 3 ? "Attention: Ce gardien est particulièrement redoutable!" : ""
            ], frameColor: .cyan)
            
            TerminalUI.waitForEnter()
            
            player.wins = 0
            guardian.wins = 0
            
            while player.wins < 2 && guardian.wins < 2 {
                let game = ConnectFourGame(player: player, opponent: guardian)
                let playerWon = game.playGame()
                
                // Attribuer des points selon la difficulté
                if playerWon {
                    player.totalScore += guardian.level * 20
                }
                
                TerminalUI.displayFramedText([
                    TerminalUI.colorText("SCORE ACTUEL", color: .bold),
                    "",
                    "\(player.name): \(player.wins)",
                    "\(guardian.name): \(guardian.wins)",
                    "",
                    "Points: \(player.totalScore)"
                ], frameColor: .yellow)
                
                // Si le joueur a perdu cette partie et que l'option est activée, proposer de sauter
                if !playerWon && skipLostGame && guardian.wins < 2 {
                    let skipOptions = ["Continuer le combat", "Quitter cette salle et recommencer"]
                    let skipChoice = TerminalUI.displayMenu(title: "VOUS AVEZ PERDU CETTE PARTIE", options: skipOptions)
                    
                    if skipChoice == 1 {
                        // Le joueur choisit d'abandonner ce niveau
                        guardian.wins = 2 // Forcer la défaite
                        break
                    }
                } else {
                    TerminalUI.waitForEnter()
                }
            }
            
            if player.wins >= 2 {
                TerminalUI.displayFramedText([
                    TerminalUI.colorText("VICTOIRE DANS LA SALLE \(currentRoom)!", color: .brightGreen),
                    "",
                    "Vous avez vaincu \(guardian.name) et pouvez maintenant explorer plus loin!",
                    "",
                    "Votre rang actuel: \(player.rank)",
                    "Points: \(player.totalScore)",
                    "",
                    "La porte suivante s'ouvre..."
                ], frameColor: .green)
                
                // Bonus pour avoir terminé une salle
                player.totalScore += currentRoom * 50
                
                // Explorer une nouvelle salle entre les niveaux si ce n'est pas la fin et si narration active
                if currentRoom < mansionGuardians.count && !skipNarration {
                    // Afficher les événements entre les niveaux
                    StoryEvents.displayEventBetweenLevels(currentLevel: currentRoom, nextLevel: currentRoom + 1, playerName: player.name)
                    
                    // Récupérer les choix réalisés par le joueur depuis StoryEvents
                    lastRoomChoice = StoryEvents.lastRoomChoice
                    lastActionChoice = StoryEvents.lastActionChoice
                    
                    // Appliquer les effets des choix du joueur
                    let choiceScoreEffect = StoryEvents.getChoiceScoreEffect(currentLevel: currentRoom, roomIndex: lastRoomChoice, choiceIndex: lastActionChoice)
                    player.totalScore += choiceScoreEffect
                    
                    // Appliquer les bonus d'énigme si une énigme a été résolue
                    let enigmaBonus = StoryEvents.getEnigmaBonus()
                    if enigmaBonus > 0 {
                        player.totalScore += enigmaBonus
                        TerminalUI.displayFramedText([
                            TerminalUI.colorText("BONUS D'ÉNIGME", color: .brightMagenta),
                            "",
                            "Votre perspicacité face à l'énigme vous rapporte \(enigmaBonus) points supplémentaires!",
                            "",
                            "Score total: \(player.totalScore)"
                        ], frameColor: .magenta)
                        
                        TerminalUI.waitForEnter()
                    }
                }
                
                TerminalUI.waitForEnter()
                currentRoom += 1
                
                if currentRoom > mansionGuardians.count {
                    mansionCompleted = true
                    break
                }
            } else {
                TerminalUI.displayFramedText([
                    TerminalUI.colorText("DÉFAITE!", color: .brightRed),
                    "",
                    "Vous avez été vaincu par \(guardian.name).",
                    "",
                    "Votre rang final: \(player.rank)",
                    "Points: \(player.totalScore)",
                    "",
                    "Une brume étrange vous enveloppe et vous ramène au hall d'entrée..."
                ], frameColor: .red)
                
                TerminalUI.waitForEnter()
                break
            }
        }
        
        if mansionCompleted {
            displayEscape()
        } else {
            displayCaptivity(room: currentRoom)
        }
    }
    
    // Fonction pour afficher l'évasion réussie
    private func displayEscape() {
        let doors = """
                 ______
              .-"      "-.
             /            \\
            |              |
            |,  .-.  .-.  ,|
            | )(__/  \\__)( |
            |/     /\\     \\|
            (_     ^^     _)
             \\__|IIIIII|__/
              | \\IIIIII/ |
              \\          /
               `--------`
        """
        
        TerminalUI.clearScreen()
        print(TerminalUI.colorText(doors, color: .brightCyan))
        
        TerminalUI.displayFramedText([
            TerminalUI.colorText("🚪 VOUS VOUS ÊTES ÉCHAPPÉ! 🚪", color: .bold),
            "",
            "Félicitations, \(player.name)!",
            "",
            "Vous avez vaincu tous les gardiens et échappé au Manoir des Quatre Piliers!",
            "Votre nom sera à jamais gravé dans l'histoire de ce lieu mystérieux.",
            "",
            "Votre rang final: \(player.rank)",
            "Score total: \(player.totalScore)"
        ], frameColor: .green)
        
        // Ajouter l'épilogue de victoire si narration active
        if !skipNarration {
            Prologue.displayEpilogueAfterVictory(playerName: player.name)
        }
        
        TerminalUI.waitForEnter(prompt: "Appuyez sur Entrée pour revenir au menu principal...")
    }
    
    // Fonction pour afficher la captivité en cas de défaite
    private func displayCaptivity(room: Int) {
        TerminalUI.clearScreen()
        
        TerminalUI.displayFramedText([
            TerminalUI.colorText("PRISONNIER DU MANOIR", color: .bold),
            "",
            "Vous êtes resté bloqué à la salle \(room).",
            "",
            "Votre rang final: \(player.rank)",
            "Score total: \(player.totalScore)",
            "",
            "Le manoir continuera à vous hanter jusqu'à ce que vous trouviez la sortie."
        ], frameColor: .blue)
        
        // Ajouter l'épilogue de défaite si narration active
        if !skipNarration {
            Prologue.displayEpilogueAfterDefeat(playerName: player.name, level: room)
        }
        
        TerminalUI.waitForEnter(prompt: "Appuyez sur Entrée pour revenir au menu principal...")
    }
}

// Fonction pour sauvegarder l'état du jeu dans un fichier JSON
func saveGameState(to filePath: String, gameState: [String: Any]) {
    do {
        let data = try JSONSerialization.data(withJSONObject: gameState, options: .prettyPrinted)
        try data.write(to: URL(fileURLWithPath: filePath))
        print("Game state saved successfully.")
    } catch {
        print("Failed to save game state: \(error)")
    }
}

// Fonction pour charger l'état du jeu à partir d'un fichier JSON
func loadGameState(from filePath: String) -> [String: Any]? {
    do {
        let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
        if let gameState = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            print("Game state loaded successfully.")
            return gameState
        }
    } catch {
        print("Failed to load game state: \(error)")
    }
    return nil
} 