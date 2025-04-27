import Foundation

// MARK: - Événements narratifs du jeu

// Classe qui gère les événements narratifs et les choix du joueur
class StoryEvents {
    
    // Structure pour représenter un choix avec ses conséquences
    struct StoryChoice {
        let text: String // Texte du choix proposé au joueur
        let outcomeText: String // Texte décrivant le résultat du choix
        let scoreEffect: Int // Effet sur le score du joueur
    }
    
    // Structure pour représenter une énigme
    struct Enigma {
        let question: String // Question posée au joueur
        let options: [String] // Options de réponse possibles
        let correctAnswerIndex: Int // Index de la réponse correcte
        let successText: String // Texte affiché en cas de succès
        let failureText: String // Texte affiché en cas d'échec
        let scoreEffect: Int // Points gagnés en cas de réussite
    }
    
    // Représente une pièce dans le manoir
    struct Room {
        let name: String // Nom de la salle
        let description: String // Description de la salle
        let choices: [StoryChoice] // Choix disponibles dans la salle
        let hasEnigma: Bool // Indique si la salle contient une énigme
    }
    
    // Les énigmes disponibles dans le manoir
    static let enigmas: [Enigma] = [
        Enigma(
            question: "Je suis ce qui reste quand tout a été oublié. Plus j'existe, moins vous savez qui vous êtes. Qui suis-je?",
            options: ["Le néant", "L'oubli", "La peur", "Le temps"],
            correctAnswerIndex: 1,
            successText: "Exactement! L'oubli est ce qui reste quand tout est perdu. Vous sentez votre esprit s'éclaircir.",
            failureText: "Votre réponse se perd dans les ombres du manoir. Quelque chose vous échappe...",
            scoreEffect: 50
        ),
        
        Enigma(
            question: "Je suis à la fois plein et vide, je n'existe que lorsqu'on m'observe, et pourtant je cache plus que je ne montre. Qui suis-je?",
            options: ["Un miroir", "Le ciel", "Un rêve", "Le silence"],
            correctAnswerIndex: 0,
            successText: "Brillant! Le miroir révèle et dissimule à la fois. Un symbole parfait de ce manoir.",
            failureText: "La réponse vous échappe, se reflétant juste hors de portée de votre compréhension.",
            scoreEffect: 60
        ),
        
        Enigma(
            question: "Quatre joueurs s'affrontent autour d'une grille. Combien de configurations gagnantes différentes sont possibles dans une partie classique de Puissance 4?",
            options: ["69", "42", "13", "21"],
            correctAnswerIndex: 0,
            successText: "Impressionnant! Vous maîtrisez vraiment la théorie du jeu. Cette connaissance vous sera utile.",
            failureText: "La réponse correcte est 69. Connaître son ennemi est la première étape vers la victoire.",
            scoreEffect: 70
        ),
        
        Enigma(
            question: "Dans ce manoir, je suis celui qui voit sans être vu, qui entend sans être entendu. Je ne suis ni gardien, ni prisonnier. Qui suis-je?",
            options: ["Le propriétaire", "Le fantôme", "Le temps", "Les murs"],
            correctAnswerIndex: 3,
            successText: "Perspicace! Les murs du manoir sont les témoins silencieux de tous les événements qui s'y déroulent.",
            failureText: "Votre réponse résonne dans le vide. Les murs semblent se moquer de votre ignorance.",
            scoreEffect: 80
        ),
        
        Enigma(
            question: "Je suis le premier quand vous entrez, le dernier quand vous sortez, mais je ne suis jamais à l'intérieur. Qui suis-je dans ce manoir?",
            options: ["La porte", "La clé", "Le seuil", "L'espoir"],
            correctAnswerIndex: 2,
            successText: "Parfait! Le seuil marque la frontière entre deux mondes. Vous comprenez les subtilités de ce lieu.",
            failureText: "Vous hésitez et la réponse vous échappe. Le seuil reste un mystère pour vous.",
            scoreEffect: 90
        )
    ];
    
    // Salles supplémentaires pour enrichir l'exploration
    static let additionalRooms: [Room] = [
        Room(
            name: "Le Laboratoire Alchimique",
            description: "Une salle remplie de fioles colorées, d'alambics et de formules étranges écrites sur les murs. L'air est saturé de vapeurs aux senteurs indéfinissables.",
            choices: [
                StoryChoice(
                    text: "Examiner les formules sur les murs",
                    outcomeText: "Les formules semblent décrire des stratégies de jeu. Vous reconnaissez des schémas de Puissance 4 traduits en équations alchimiques.",
                    scoreEffect: 45
                ),
                StoryChoice(
                    text: "Mélanger deux potions au hasard",
                    outcomeText: "Le mélange crée une fumée qui forme des figures géométriques dans l'air. Vous y discernez des configurations gagnantes!",
                    scoreEffect: 30
                ),
                StoryChoice(
                    text: "Goûter prudemment une potion bleue",
                    outcomeText: "La potion a un goût de myrtille. Votre vision s'améliore temporairement, vous permettant de voir les mouvements avec une clarté surnaturelle.",
                    scoreEffect: 60
                )
            ],
            hasEnigma: true
        ),
        
        Room(
            name: "La Galerie des Portraits",
            description: "Un long couloir orné de portraits anciens. Les yeux des personnages peints semblent suivre vos mouvements. Chaque tableau représente un ancien propriétaire du manoir.",
            choices: [
                StoryChoice(
                    text: "Observer attentivement les expressions des portraits",
                    outcomeText: "Vous remarquez que certains portraits sourient subtilement. Leurs positions forment un motif qui évoque une stratégie de jeu.",
                    scoreEffect: 40
                ),
                StoryChoice(
                    text: "Lire les plaques sous les portraits",
                    outcomeText: "Les dates et noms révèlent un schéma. Vous comprenez que les propriétaires du manoir étaient tous des maîtres du jeu stratégique.",
                    scoreEffect: 50
                ),
                StoryChoice(
                    text: "Toucher le cadre du portrait central",
                    outcomeText: "Le cadre pivote légèrement, révélant une cavité contenant un petit livre de stratégies annotées par les anciens maîtres.",
                    scoreEffect: 65
                )
            ],
            hasEnigma: false
        ),
        
        Room(
            name: "La Salle des Horloges",
            description: "Une pièce circulaire où des dizaines d'horloges de toutes tailles indiquent des heures différentes. Le tic-tac incessant crée une étrange mélodie rythmique.",
            choices: [
                StoryChoice(
                    text: "Synchroniser quelques horloges",
                    outcomeText: "Quand les aiguilles s'alignent, un panneau secret s'ouvre, révélant un parchemin avec des annotations sur le timing parfait au jeu.",
                    scoreEffect: 55
                ),
                StoryChoice(
                    text: "Étudier le motif formé par les aiguilles",
                    outcomeText: "Les aiguilles de toutes les horloges forment un schéma complexe qui, vu d'en haut, ressemble à une stratégie parfaite de Puissance 4.",
                    scoreEffect: 70
                ),
                StoryChoice(
                    text: "Écouter attentivement le rythme des tic-tacs",
                    outcomeText: "Le rythme entre dans votre subconscient. Vous réalisez qu'il s'agit d'un code temporel pour anticiper les mouvements adverses.",
                    scoreEffect: 60
                )
            ],
            hasEnigma: true
        ),
        
        Room(
            name: "Le Jardin de Statues",
            description: "Un jardin intérieur où des statues de joueurs d'échecs et de stratèges célèbres sont disposées selon un motif précis. La lumière crée des ombres qui semblent animer les figures de pierre.",
            choices: [
                StoryChoice(
                    text: "Analyser la disposition des statues",
                    outcomeText: "Vues d'un certain angle, les statues forment une grille de Puissance 4 avec une situation de jeu précise. Vous mémorisez cette configuration.",
                    scoreEffect: 65
                ),
                StoryChoice(
                    text: "Lire les inscriptions sur les socles",
                    outcomeText: "Les inscriptions contiennent des maximes sur la stratégie et la patience. Une en particulier vous frappe: 'Le centre est le pouvoir, les bords sont le piège.'",
                    scoreEffect: 45
                ),
                StoryChoice(
                    text: "Observer le mouvement des ombres",
                    outcomeText: "À mesure que le soleil se déplace, les ombres révèlent des séquences de mouvements gagnants. C'est comme si les statues jouaient une partie invisible.",
                    scoreEffect: 75
                )
            ],
            hasEnigma: false
        ),
        
        Room(
            name: "La Chambre des Échos",
            description: "Une salle vide aux propriétés acoustiques étranges. Chaque son y est répété plusieurs fois, se transformant subtilement à chaque écho.",
            choices: [
                StoryChoice(
                    text: "Prononcer le nom du gardien suivant",
                    outcomeText: "Les échos transforment le nom en une série d'indices sur sa stratégie de jeu. Vous percevez ses faiblesses dans les vibrations de l'air.",
                    scoreEffect: 80
                ),
                StoryChoice(
                    text: "Frapper un rythme sur le mur",
                    outcomeText: "Les échos créent un contrepoint complexe qui traduit, en langage sonore, une séquence parfaite de coups pour votre prochaine partie.",
                    scoreEffect: 60
                ),
                StoryChoice(
                    text: "Rester parfaitement silencieux",
                    outcomeText: "Dans le silence absolu, vous percevez d'infimes vibrations: ce sont les mouvements du gardien suivant que vous anticipez désormais.",
                    scoreEffect: 70
                )
            ],
            hasEnigma: true
        )
    ];
    
    // Les différentes salles disponibles après chaque niveau
    static let rooms: [[Room]] = [
        // Après le niveau 1
        [
            Room(
                name: "La Bibliothèque",
                description: "Une vaste salle avec des étagères remplies de livres poussiéreux. L'air y est chargé de savoir.",
                choices: [
                    StoryChoice(
                        text: "Consulter un livre sur l'histoire du manoir",
                        outcomeText: "Vous découvrez un indice sur la faiblesse du prochain gardien: il a tendance à négliger les diagonales.",
                        scoreEffect: 30
                    ),
                    StoryChoice(
                        text: "Chercher un passage secret derrière les étagères",
                        outcomeText: "Vous trouvez un petit coffre contenant un médaillon. Il semble renforcer votre concentration.",
                        scoreEffect: 50
                    ),
                    StoryChoice(
                        text: "Continuer sans perdre de temps",
                        outcomeText: "Vous préférez ne pas vous attarder et continuez vers la prochaine salle.",
                        scoreEffect: 0
                    )
                ],
                hasEnigma: false
            ),
            Room(
                name: "La Cuisine",
                description: "Une cuisine ancienne avec des ustensiles suspendus et un feu qui crépite dans l'âtre.",
                choices: [
                    StoryChoice(
                        text: "Inspecter les tiroirs",
                        outcomeText: "Vous trouvez une recette étrange qui semble être un indice codé sur la stratégie du prochain gardien.",
                        scoreEffect: 40
                    ),
                    StoryChoice(
                        text: "Goûter la soupe qui mijote",
                        outcomeText: "La soupe a un goût étrange... Elle vous fait voir trouble pendant un moment, mais vous donne ensuite une clarté d'esprit inhabituelle.",
                        scoreEffect: 20
                    ),
                    StoryChoice(
                        text: "Continuer sans toucher à rien",
                        outcomeText: "Vous décidez de ne rien toucher, méfiant de ce que pourrait contenir cette cuisine.",
                        scoreEffect: 10
                    )
                ],
                hasEnigma: true
            ),
            additionalRooms[0] // Le Laboratoire Alchimique
        ],
        
        // Après le niveau 2
        [
            Room(
                name: "La Salle des Miroirs",
                description: "Une pièce circulaire avec des miroirs du sol au plafond. Votre reflet semble vous observer.",
                choices: [
                    StoryChoice(
                        text: "Observer attentivement les reflets",
                        outcomeText: "Dans l'un des miroirs, vous apercevez brièvement le visage du prochain gardien. Cette vision vous prépare à l'affrontement.",
                        scoreEffect: 45
                    ),
                    StoryChoice(
                        text: "Briser un miroir",
                        outcomeText: "Le miroir se brise en mille morceaux! Un passage s'ouvre derrière... mais vous ressentez une sensation de malchance.",
                        scoreEffect: -20
                    ),
                    StoryChoice(
                        text: "Fermer les yeux et traverser rapidement",
                        outcomeText: "Vous traversez la pièce sans regarder les miroirs, évitant ainsi leur possible influence néfaste.",
                        scoreEffect: 15
                    )
                ],
                hasEnigma: true
            ),
            Room(
                name: "Le Jardin d'Hiver",
                description: "Une serre magnifique où poussent des plantes exotiques. L'air y est chaud et humide.",
                choices: [
                    StoryChoice(
                        text: "Sentir une fleur étrange",
                        outcomeText: "Le parfum de la fleur vous enivre et vous donne une étrange sensation de lucidité stratégique.",
                        scoreEffect: 35
                    ),
                    StoryChoice(
                        text: "Boire l'eau de la fontaine",
                        outcomeText: "L'eau est fraîche et pure. Vous vous sentez revitalisé et prêt pour le prochain défi.",
                        scoreEffect: 25
                    ),
                    StoryChoice(
                        text: "Examiner les motifs du carrelage",
                        outcomeText: "Les motifs forment une grille qui ressemble étrangement à un plateau de Puissance 4. Vous y découvrez une stratégie intéressante.",
                        scoreEffect: 50
                    )
                ],
                hasEnigma: false
            ),
            additionalRooms[1], // La Galerie des Portraits
            additionalRooms[2]  // La Salle des Horloges
        ],
        
        // Après le niveau 3
        [
            Room(
                name: "La Salle de Musique",
                description: "Une pièce ornée d'instruments anciens. Un piano semble attendre qu'on joue une mélodie.",
                choices: [
                    StoryChoice(
                        text: "Jouer quelques notes sur le piano",
                        outcomeText: "Les notes résonnent dans la pièce. Une partition secrète apparaît, révélant un schéma qui pourrait être utile contre le prochain gardien.",
                        scoreEffect: 60
                    ),
                    StoryChoice(
                        text: "Écouter le silence de la pièce",
                        outcomeText: "Dans le silence, vous percevez un rythme subtil, comme un indice sur le style de jeu du prochain adversaire.",
                        scoreEffect: 40
                    ),
                    StoryChoice(
                        text: "Examiner les cordes du violon",
                        outcomeText: "En touchant les cordes, une vibration étrange se propage jusqu'à votre esprit, vous donnant un aperçu de la stratégie à adopter.",
                        scoreEffect: 30
                    )
                ],
                hasEnigma: false
            ),
            Room(
                name: "L'Observatoire",
                description: "Une tour circulaire avec un plafond ouvert sur le ciel étoilé. Un immense télescope pointe vers les constellations.",
                choices: [
                    StoryChoice(
                        text: "Observer les étoiles",
                        outcomeText: "Les constellations semblent former des motifs similaires à des configurations gagnantes au Puissance 4. Vous mémorisez ces schémas.",
                        scoreEffect: 70
                    ),
                    StoryChoice(
                        text: "Consulter les cartes célestes",
                        outcomeText: "Les anciens parchemins révèlent des stratégies utilisées par les gardiens depuis des siècles.",
                        scoreEffect: 50
                    ),
                    StoryChoice(
                        text: "Activer le mécanisme du télescope",
                        outcomeText: "Le télescope se met en mouvement et projette une image sur le sol: c'est une grille avec des configurations de jeu à éviter!",
                        scoreEffect: 45
                    )
                ],
                hasEnigma: true
            ),
            additionalRooms[3], // Le Jardin de Statues
            additionalRooms[4]  // La Chambre des Échos
        ],
        
        // Après le niveau 4
        [
            Room(
                name: "La Crypte",
                description: "Un espace souterrain froid et humide, avec des inscriptions anciennes sur les murs.",
                choices: [
                    StoryChoice(
                        text: "Déchiffrer les inscriptions",
                        outcomeText: "Les symboles racontent l'histoire du dernier gardien et révèlent sa plus grande faiblesse.",
                        scoreEffect: 80
                    ),
                    StoryChoice(
                        text: "Allumer les bougies rituelles",
                        outcomeText: "Les flammes projettent des ombres qui dansent et forment des motifs stratégiques. Vous y voyez une révélation.",
                        scoreEffect: 65
                    ),
                    StoryChoice(
                        text: "Méditer au centre de la pièce",
                        outcomeText: "Dans le silence absolu, votre esprit atteint une clarté sans précédent. Vous êtes prêt pour l'ultime confrontation.",
                        scoreEffect: 75
                    )
                ],
                hasEnigma: false
            ),
            Room(
                name: "La Chambre des Secrets",
                description: "Une petite pièce remplie d'objets étranges et de mécanismes complexes.",
                choices: [
                    StoryChoice(
                        text: "Résoudre l'énigme du coffre",
                        outcomeText: "Le coffre s'ouvre et révèle un vieux journal qui détaille les stratégies du Grand Maître.",
                        scoreEffect: 90
                    ),
                    StoryChoice(
                        text: "Activer la machine à illusions",
                        outcomeText: "La machine projette une simulation de partie contre le dernier gardien. Vous analysez son style de jeu.",
                        scoreEffect: 85
                    ),
                    StoryChoice(
                        text: "Examiner le tableau chiffré",
                        outcomeText: "Les chiffres sur le tableau forment un modèle mathématique qui prédit les coups optimaux contre le dernier adversaire.",
                        scoreEffect: 70
                    )
                ],
                hasEnigma: true
            )
        ]
    ]
    
    static func displayEventBetweenLevels(currentLevel: Int, nextLevel: Int, playerName: String) {
        if currentLevel - 1 >= rooms.count {
            return
        }
        
        let availableRooms = rooms[currentLevel - 1]
        TerminalUI.clearScreen()
        
        TerminalUI.displayFramedText([
            TerminalUI.colorText("EXPLORATION DU MANOIR", color: .bold),
            "",
            "Après avoir vaincu le gardien, vous découvrez un couloir qui mène à plusieurs salles.",
            "Quelle direction souhaitez-vous prendre?"
        ], frameColor: .cyan)
        
        // Proposer les salles disponibles
        var roomOptions: [String] = []
        for room in availableRooms {
            roomOptions.append(room.name)
        }
        
        let roomChoice = TerminalUI.displayMenu(title: "CHOISISSEZ VOTRE CHEMIN", options: roomOptions)
        let selectedRoom = availableRooms[roomChoice]
        
        // Stocker le choix de salle pour le GameController
        lastRoomChoice = roomChoice
        
        // Afficher la description de la salle
        TerminalUI.clearScreen()
        TerminalUI.displayFramedText([
            TerminalUI.colorText(selectedRoom.name, color: .bold),
            "",
            selectedRoom.description
        ], frameColor: .cyan)
        
        Thread.sleep(forTimeInterval: 1.0)
        
        // Si la salle contient une énigme, la présenter d'abord
        if selectedRoom.hasEnigma && currentLevel - 1 < enigmas.count {
            presentEnigma(enigma: enigmas[currentLevel - 1], roomName: selectedRoom.name)
        }
        
        // Proposer les choix dans cette salle
        var choiceOptions: [String] = []
        for choice in selectedRoom.choices {
            choiceOptions.append(choice.text)
        }
        
        let actionChoice = TerminalUI.displayMenu(title: "QUE SOUHAITEZ-VOUS FAIRE?", options: choiceOptions)
        let selectedChoice = selectedRoom.choices[actionChoice]
        
        // Stocker le choix d'action pour le GameController
        lastActionChoice = actionChoice
        
        // Afficher le résultat du choix
        TerminalUI.clearScreen()
        TerminalUI.displayFramedText([
            TerminalUI.colorText("CONSÉQUENCE", color: .bold),
            "",
            selectedChoice.outcomeText
        ], frameColor: .green)
        
        // Appliquer l'effet du choix (ici, juste afficher)
        if selectedChoice.scoreEffect != 0 {
            let effectText = selectedChoice.scoreEffect > 0 
                ? "Vous gagnez \(selectedChoice.scoreEffect) points d'expérience."
                : "Vous perdez \(abs(selectedChoice.scoreEffect)) points d'expérience."
            
            TerminalUI.displayAnimation(text: effectText)
        }
        
        TerminalUI.waitForEnter()
    }
    
    // Méthode pour présenter une énigme au joueur
    private static func presentEnigma(enigma: Enigma, roomName: String) {
        TerminalUI.clearScreen()
        
        TerminalUI.displayFramedText([
            TerminalUI.colorText("ÉNIGME DE " + roomName.uppercased(), color: .bold),
            "",
            "Une voix mystérieuse résonne dans votre tête :",
            "",
            enigma.question
        ], frameColor: .magenta)
        
        let answer = TerminalUI.displayMenu(title: "QUELLE EST VOTRE RÉPONSE?", options: enigma.options)
        
        TerminalUI.clearScreen()
        
        if answer == enigma.correctAnswerIndex {
            TerminalUI.displayFramedText([
                TerminalUI.colorText("RÉPONSE CORRECTE!", color: .brightGreen),
                "",
                enigma.successText,
                "",
                "Vous gagnez \(enigma.scoreEffect) points d'expérience."
            ], frameColor: .green)
            
            // Note: Le GameController récupérera ces points
            enigmaSuccess = true
            enigmaScoreEffect = enigma.scoreEffect
        } else {
            TerminalUI.displayFramedText([
                TerminalUI.colorText("RÉPONSE INCORRECTE", color: .red),
                "",
                enigma.failureText
            ], frameColor: .red)
            
            enigmaSuccess = false
            enigmaScoreEffect = 0
        }
        
        TerminalUI.waitForEnter()
    }
    
    // Variables pour stocker les résultats d'énigmes
    static var enigmaSuccess: Bool = false
    static var enigmaScoreEffect: Int = 0
    static var lastRoomChoice: Int = 0
    static var lastActionChoice: Int = 0
    
    // Méthode pour retourner l'effet de score du choix fait par le joueur
    static func getChoiceScoreEffect(currentLevel: Int, roomIndex: Int, choiceIndex: Int) -> Int {
        if currentLevel - 1 < rooms.count && roomIndex < rooms[currentLevel - 1].count && choiceIndex < rooms[currentLevel - 1][roomIndex].choices.count {
            return rooms[currentLevel - 1][roomIndex].choices[choiceIndex].scoreEffect
        }
        return 0
    }
    
    // Méthode pour récupérer le bonus d'énigme si résolue
    static func getEnigmaBonus() -> Int {
        if enigmaSuccess {
            let bonus = enigmaScoreEffect
            enigmaScoreEffect = 0 // Réinitialiser pour éviter de compter deux fois
            return bonus
        }
        return 0
    }
} 