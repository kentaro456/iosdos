import Foundation

// MARK: - Point d'entrée du jeu

// Initialisation du contrôleur de jeu
let gameController = GameController()

// Personnalisation de l'interface (optionnel, peut être retiré si non désiré)
TerminalUI.boardStyle = .unicode 
// Note: Si vous retirez l'option du menu, vous pouvez fixer le style ici
// ou le retirer complètement si vous n'en voulez qu'un seul.

// Démarrage du jeu (commence directement par le prologue via GameController)
gameController.startGame()

// La fonction showWelcomeScreen() est maintenant supprimée 