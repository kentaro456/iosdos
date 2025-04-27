import Foundation

// MARK: - Narrateur et prologue du jeu

class Prologue {
    
    static func displayPrologue() {
        TerminalUI.clearScreen()
        
        let legend = [
            "Bienvenue au Manoir des Quatre Piliers!",
            "",
            "Vous vous réveillez dans le hall d'un manoir abandonné et mystérieux.",
            "Une lettre posée sur une table vous informe que vous êtes prisonnier.",
            "Pour sortir, vous devrez traverser les quatre ailes du manoir.",
            "",
            "Chaque aile est protégée par un gardien, maître du jeu de Puissance 4.",
            "L'objectif: aligner quatre jetons et vaincre le gardien pour accéder à la salle suivante.",
            "",
            "Des choix s'offriront à vous à chaque étape de votre parcours.",
            "Certains chemins seront plus faciles, d'autres plus risqués...",
            "",
            "Faites preuve de sagesse dans vos choix et de stratégie dans vos parties.",
            "Le manoir regorge de secrets, et votre liberté dépend de votre intelligence.",
            "Votre aventure commence maintenant..."
        ]
        
        for line in legend {
            if line.isEmpty {
                print()
                Thread.sleep(forTimeInterval: 0.3)
            } else {
                TerminalUI.displayAnimation(text: line)
                Thread.sleep(forTimeInterval: 0.5)
            }
        }
        
        TerminalUI.waitForEnter()
    }
    
    static func displayEpilogueAfterVictory(playerName: String) {
        TerminalUI.clearScreen()
        
        let epilogue = [
            "Félicitations, \(playerName)! Vous avez vaincu tous les gardiens du manoir.",
            "Alors que vous ouvrez la porte du dernier gardien, une lumière aveuglante vous enveloppe.",
            "Vous vous réveillez à l'extérieur du manoir, libre et victorieux!"
        ]
        
        for line in epilogue {
            TerminalUI.displayAnimation(text: line)
        }
        
        TerminalUI.waitForEnter()
    }
    
    static func displayEpilogueAfterDefeat(playerName: String, level: Int) {
        TerminalUI.clearScreen()
        
        let epilogue = [
            "Vous avez été vaincu dans la salle \(level) du manoir.",
            "Une brume étrange vous enveloppe et vous perdez connaissance...",
            "Vous vous réveillez à nouveau dans le hall d'entrée, condamné à réessayer."
        ]
        
        for line in epilogue {
            TerminalUI.displayAnimation(text: line)
        }
        
        TerminalUI.waitForEnter()
    }
} 