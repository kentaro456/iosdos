# Rapport Technique - Jeu d'Aventure Textuel en Swift

## Choix de conception

### Architecture générale
J'ai conçu le jeu avec une architecture MVC simplifiée :
- **Modèle** : Les structures de données définies dans `Models.swift`, représentant les éléments du jeu (salles, objets, personnages, etc.)
- **Vue** : L'interface en ligne de commande gérée par les fonctions d'affichage du `GameController`
- **Contrôleur** : Le `GameController` qui gère la logique du jeu et le traitement des commandes

Cette architecture permet une séparation claire des responsabilités et facilite la maintenance du code.

### Persistance des données
J'ai implémenté un système de chargement et de sauvegarde utilisant JSON :
1. Les données du monde du jeu sont définies dans `gameData.json`
2. L'état du jeu est sauvegardé dans `gameSave.json`

Ce choix permet de modifier facilement le contenu du jeu sans toucher au code Swift, ce qui rend l'extension du jeu plus simple pour les non-programmeurs.

### Système de commandes
J'ai opté pour un système de commandes textuelles avec arguments, traité via un analyseur syntaxique simple :
1. Séparation de la commande et des arguments
2. Traitement spécifique selon la commande
3. Validation des entrées et messages d'erreur explicites

Cette approche est intuitive pour les joueurs habitués aux jeux d'aventure textuels classiques.

## Choix des types de données

### Structures vs Classes
J'ai privilégié l'utilisation de structures (`struct`) plutôt que de classes pour la plupart des éléments du jeu :
- Avantages : types valeur, immutabilité par défaut, performances
- Classes utilisées uniquement pour le GameController qui maintient l'état global

### Énumérations
J'ai créé une énumération pour les directions, ce qui permet :
- Une meilleure sécurité de type
- La prévention des erreurs liées aux chaînes de caractères
- Une intégration avec le protocole Codable pour la sérialisation JSON

### Types optionnels
J'ai utilisé des types optionnels pour les propriétés qui peuvent ne pas exister :
- `requiredForPuzzle?: String` - Un objet peut ou non être requis pour une énigme
- `rewardItemId?: String` - Une énigme peut ou non donner un objet en récompense
- `timeEvents?: [TimeEvent]` - Une salle peut ou non avoir des événements temporels

## Fonctionnalités avancées implémentées

### 1. Système d'événements temporels
J'ai implémenté un système complet d'événements basés sur le temps :
- Variable `gameTime` dans la structure `Player` qui s'incrémente à chaque déplacement ou utilisation de la commande `attendre`
- Événements déclenchés à des moments spécifiques via la propriété `triggerTime`
- Personnages disponibles uniquement à certaines heures via la propriété `availableTimes`

Cela crée une dimension supplémentaire au jeu, où le joueur doit parfois attendre le bon moment pour rencontrer certains personnages ou assister à certains événements.

### 2. Carte du joueur
J'ai développé un système de visualisation de carte ASCII :
- Génération d'une grille 2D représentant les salles
- Positionnement des salles et traçage des connexions entre elles
- Indication de la position actuelle du joueur

Cette fonctionnalité aide les joueurs à se repérer dans l'espace du jeu, ce qui est particulièrement utile dans un jeu d'aventure textuel où la navigation peut parfois être difficile.

## Défis rencontrés et solutions

### 1. Modélisation des énigmes
**Défi** : Créer un système flexible pour différents types d'énigmes.

**Solution** : J'ai conçu la structure `Puzzle` avec des propriétés optionnelles permettant de définir différents types d'énigmes :
- Énigmes nécessitant des objets spécifiques (`requiredItemIds`)
- Énigmes nécessitant des commandes spécifiques (`requiredCommand`)
- Énigmes avec limite de temps (`timeLimit`)

### 2. Interactions entre objets
**Défi** : Permettre la combinaison d'objets de manière intuitive.

**Solution** : J'ai implémenté un système de combinaison avec les propriétés :
- `combinableWith` : ID de l'objet avec lequel combiner
- `combinationResult` : ID de l'objet résultant

Cela permet de créer facilement des recettes de combinaison dans les données JSON sans modifier le code.

### 3. Gestion du temps
**Défi** : Créer un système de temps cohérent affectant le monde du jeu.

**Solution** : 
- Implémentation d'un cycle jour/nuit sur 24 unités de temps
- Descriptions temporelles adaptées à l'heure actuelle
- Personnages et événements liés à des plages horaires spécifiques

### 4. Dessin de la carte
**Défi** : Représenter visuellement les salles et leurs connections dans une interface texte.

**Solution** :
- Algorithme simple de tracé de lignes pour les connections
- Positionnement des salles sur une grille avec des symboles distincts
- Légende explicite pour aider à comprendre la carte

## Conclusion

Ce projet de jeu d'aventure textuel m'a permis d'explorer la programmation Swift dans un contexte ludique, tout en mettant en œuvre des concepts importants comme la sérialisation JSON, la conception orientée objet, et l'architecture MVC.

Les fonctionnalités avancées de gestion du temps et de carte ajoutent une dimension supplémentaire à l'expérience de jeu classique des aventures textuelles.

Le code a été conçu avec la maintenabilité et l'extensibilité en tête, permettant d'ajouter facilement de nouvelles salles, objets, énigmes et personnages simplement en modifiant le fichier JSON de données. 