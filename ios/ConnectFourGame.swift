import Foundation
#if os(Windows)
import WinSDK
#endif

// MARK: - Jeu de Puissance 4

class ConnectFourGame {
    private let rows = 6
    private let cols = 7
    private var board: [[CellState]]
    private var currentPlayer: Bool // true = player, false = AI
    private var player: Player
    private var opponent: AIOpponent
    private var isGameRunning = true
    private var moveHistory: [(row: Int, col: Int, player: Bool)] = []
    
    init(player: Player, opponent: AIOpponent) {
        self.player = player
        self.opponent = opponent
        self.board = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        self.currentPlayer = true // Player starts
    }
    
    func playGame() -> Bool {
        TerminalUI.clearScreen()
        TerminalUI.displayFramedText([
            TerminalUI.colorText("MATCH CONTRE \(opponent.name.uppercased())", color: .bold),
            "",
            "Niveau: \(opponent.level) - Difficulté: \(getDifficultyString())",
            "",
            opponent.introText
        ], frameColor: .magenta)
        
        TerminalUI.waitForEnter()
        
        while isGameRunning {
            TerminalUI.clearScreen()
            displayBoard()
            
            if currentPlayer {
                playerTurn()
            } else {
                aiTurn()
            }
            
            if checkForWin() {
                TerminalUI.clearScreen()
                displayBoard()
                if currentPlayer {
                    player.wins += 1
                    TerminalUI.displayFramedText([
                        TerminalUI.colorText("VICTOIRE!", color: .brightGreen),
                        "",
                        "Vous avez battu \(opponent.name)!",
                        "",
                        opponent.loseText
                    ], frameColor: .green)
                } else {
                    opponent.wins += 1
                    TerminalUI.displayFramedText([
                        TerminalUI.colorText("DÉFAITE!", color: .brightRed),
                        "",
                        "Vous avez perdu contre \(opponent.name)!",
                        "",
                        opponent.winText
                    ], frameColor: .red)
                }
                
                TerminalUI.waitForEnter()
                return currentPlayer
            } else if isBoardFull() {
                TerminalUI.clearScreen()
                displayBoard()
                TerminalUI.displayFramedText([
                    TerminalUI.colorText("MATCH NUL!", color: .brightYellow),
                    "",
                    "La grille est pleine!"
                ], frameColor: .yellow)
                
                TerminalUI.waitForEnter()
                return false
            }
            
            currentPlayer = !currentPlayer
        }
        
        return false
    }
    
    private func getDifficultyString() -> String {
        switch opponent.level {
        case 1: return "⭐"
        case 2: return "⭐⭐"
        case 3: return "⭐⭐⭐"
        case 4: return "⭐⭐⭐⭐"
        case 5: return "⭐⭐⭐⭐⭐"
        default: return "⭐"
        }
    }
    
    private func displayBoard() {
        let columnNumbers = " 1 2 3 4 5 6 7"
        print(TerminalUI.colorText(columnNumbers, color: .cyan))
        
        let horizontal = TerminalUI.boardStyle.horizontal
        let vertical = TerminalUI.boardStyle.vertical
        let corner = TerminalUI.boardStyle.corner
        
        print(TerminalUI.colorText("\(corner)\(horizontal)\(corner)", color: .cyan))
        
        for row in 0..<rows {
            var rowString = "\(vertical)"
            for col in 0..<cols {
                // Colorer différemment le dernier coup joué
                if let lastMove = moveHistory.last, lastMove.row == row && lastMove.col == col {
                    if lastMove.player {
                        rowString += TerminalUI.colorBackground(board[row][col].display, color: .brightRed) + vertical
                    } else {
                        rowString += TerminalUI.colorBackground(board[row][col].display, color: .brightBlue) + vertical
                    }
                } else {
                    rowString += board[row][col].display + vertical
                }
            }
            print(rowString)
        }
        
        print(TerminalUI.colorText("\(corner)\(horizontal)\(corner)", color: .cyan))
    }
    
    private func playerTurn() {
        var validMove = false
        while !validMove {
            print("\n" + TerminalUI.colorText("Votre tour, \(player.name). Choisissez une colonne (1-7):", color: .green))
            if let input = readLine(), let column = Int(input), column >= 1, column <= 7 {
                let col = column - 1
                if isValidMove(col: col) {
                    let row = makeMove(col: col, state: .player)
                    moveHistory.append((row: row, col: col, player: true))
                    validMove = true
                } else {
                    print(TerminalUI.colorText("Colonne pleine! Choisissez une autre colonne.", color: .red))
                }
            } else {
                print(TerminalUI.colorText("Entrée invalide! Veuillez entrer un nombre entre 1 et 7.", color: .red))
            }
        }
    }
    
    private func aiTurn() {
        print("\n" + TerminalUI.colorText("\(opponent.name) réfléchit...", color: .blue))
        
        // L'IA réfléchit plus longtemps selon son niveau
        let thinkTime = 0.3 + Double(opponent.level) * 0.2
        Thread.sleep(forTimeInterval: thinkTime)
        
        let col = calculateAIMove()
        let row = makeMove(col: col, state: .opponent)
        moveHistory.append((row: row, col: col, player: false))
        
        print(TerminalUI.colorText("\(opponent.name) joue dans la colonne \(col + 1)!", color: .blue))
        Thread.sleep(forTimeInterval: 0.3)
    }
    
    private func calculateAIMove() -> Int {
        // Stratégie basée sur les caractéristiques de l'IA
        
        // 1. Si l'IA peut gagner immédiatement, elle le fait
        if opponent.lookahead >= 1 {
            if let winningMove = findWinningMove(for: .opponent) {
                return winningMove
            }
        }
        
        // 2. Si l'IA doit bloquer une victoire du joueur, elle le fait en fonction de son agressivité
        if opponent.lookahead >= 1 && opponent.aggressivity <= 7 {
            if let blockingMove = findWinningMove(for: .player) {
                // Parfois, une IA agressive préfère attaquer plutôt que défendre
                if opponent.aggressivity >= 8 && Int.random(in: 1...10) <= opponent.aggressivity - 7 {
                    // Décide de ne pas bloquer - cherche un coup offensif à la place
                } else {
                    return blockingMove
                }
            }
        }
        
        // 3. Recherche avancée pour les IA de haut niveau
        if opponent.lookahead >= 2 {
            if let advancedMove = findAdvancedMove() {
                return advancedMove
            }
        }
        
        // 4. Préférence pour la colonne centrale en fonction de centerPreference
        if Int.random(in: 1...10) <= opponent.centerPreference {
            if let centerColumn = preferCenterColumn() {
                return centerColumn
            }
        }
        
        // 5. Coup aléatoire, plus fréquent si randomness est élevé
        return randomMove()
    }
    
    private func findAdvancedMove() -> Int? {
        // Cette méthode pourrait implémenter une recherche plus profonde pour les IA avancées
        // Comme une recherche minimax avec une profondeur basée sur le lookahead
        
        // Version simplifiée pour démonstration
        
        // Cherche les colonnes qui pourraient mener à une victoire en 2 coups
        for col in 0..<cols {
            if isValidMove(col: col) {
                let row = getNextEmptyRow(col: col)
                board[row][col] = .opponent
                
                // Vérifie si ce coup crée des menaces multiples
                var threatCount = 0
                for nextCol in 0..<cols {
                    if nextCol != col && isValidMove(col: nextCol) {
                        let nextRow = getNextEmptyRow(col: nextCol)
                        board[nextRow][nextCol] = .opponent
                        
                        if checkWinCondition(row: nextRow, col: nextCol, state: .opponent) {
                            threatCount += 1
                        }
                        
                        // Annuler le coup de test
                        board[nextRow][nextCol] = .empty
                    }
                }
                
                // Annuler le coup initial
                board[row][col] = .empty
                
                // Si un coup crée plusieurs menaces, c'est un bon coup
                if threatCount >= 2 {
                    return col
                }
            }
        }
        
        return nil
    }
    
    private func randomMove() -> Int {
        var availableCols = [Int]()
        for col in 0..<cols {
            if isValidMove(col: col) {
                availableCols.append(col)
            }
        }
        
        if availableCols.count > 0 {
            let randomIndex = Int.random(in: 0..<availableCols.count)
            return availableCols[randomIndex]
        }
        
        // Fallback (ne devrait jamais arriver si isBoardFull est correctement vérifié)
        return 0
    }
    
    private func findWinningMove(for state: CellState) -> Int? {
        // Vérifier si un coup peut gagner ou bloquer l'adversaire
        for col in 0..<cols {
            if isValidMove(col: col) {
                let row = getNextEmptyRow(col: col)
                board[row][col] = state
                
                let isWinning = checkWinCondition(row: row, col: col, state: state)
                
                // Annuler le coup
                board[row][col] = .empty
                
                if isWinning {
                    return col
                }
            }
        }
        return nil
    }
    
    private func preferCenterColumn() -> Int? {
        // Préférer les colonnes du centre qui offrent plus de possibilités
        // Ordre basé sur la proximité du centre
        let preferredCols = [3, 2, 4, 1, 5, 0, 6]
        
        for col in preferredCols {
            if isValidMove(col: col) {
                return col
            }
        }
        return nil
    }
    
    private func isValidMove(col: Int) -> Bool {
        return col >= 0 && col < cols && board[0][col] == .empty
    }
    
    private func getNextEmptyRow(col: Int) -> Int {
        for row in (0..<rows).reversed() {
            if board[row][col] == .empty {
                return row
            }
        }
        return -1 // Ne devrait jamais arriver si isValidMove est vérifié avant
    }
    
    private func makeMove(col: Int, state: CellState) -> Int {
        let row = getNextEmptyRow(col: col)
        if row >= 0 {
            board[row][col] = state
        }
        return row
    }
    
    private func checkForWin() -> Bool {
        let state = currentPlayer ? CellState.player : CellState.opponent
        
        for row in 0..<rows {
            for col in 0..<cols {
                if board[row][col] == state {
                    // Vérifier horizontalement
                    if col + 3 < cols &&
                       board[row][col+1] == state &&
                       board[row][col+2] == state &&
                       board[row][col+3] == state {
                        return true
                    }
                    
                    // Vérifier verticalement
                    if row + 3 < rows &&
                       board[row+1][col] == state &&
                       board[row+2][col] == state &&
                       board[row+3][col] == state {
                        return true
                    }
                    
                    // Vérifier diagonale descendante
                    if col + 3 < cols && row + 3 < rows &&
                       board[row+1][col+1] == state &&
                       board[row+2][col+2] == state &&
                       board[row+3][col+3] == state {
                        return true
                    }
                    
                    // Vérifier diagonale montante
                    if col + 3 < cols && row - 3 >= 0 &&
                       board[row-1][col+1] == state &&
                       board[row-2][col+2] == state &&
                       board[row-3][col+3] == state {
                        return true
                    }
                }
            }
        }
        
        return false
    }
    
    private func checkWinCondition(row: Int, col: Int, state: CellState) -> Bool {
        // Horizontal
        var count = 0
        for c in 0..<cols {
            if board[row][c] == state {
                count += 1
                if count >= 4 { return true }
            } else {
                count = 0
            }
        }
        
        // Vertical
        count = 0
        for r in 0..<rows {
            if board[r][col] == state {
                count += 1
                if count >= 4 { return true }
            } else {
                count = 0
            }
        }
        
        // Diagonale descendante
        count = 0
        var r = row - min(row, col)
        var c = col - min(row, col)
        while r < rows && c < cols {
            if board[r][c] == state {
                count += 1
                if count >= 4 { return true }
            } else {
                count = 0
            }
            r += 1
            c += 1
        }
        
        // Diagonale montante
        count = 0
        r = row + min(rows - 1 - row, col)
        c = col - min(rows - 1 - row, col)
        while r >= 0 && c < cols {
            if board[r][c] == state {
                count += 1
                if count >= 4 { return true }
            } else {
                count = 0
            }
            r -= 1
            c += 1
        }
        
        return false
    }
    
    private func isBoardFull() -> Bool {
        for col in 0..<cols {
            if board[0][col] == .empty {
                return false
            }
        }
        return true
    }
} 