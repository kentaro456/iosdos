import Foundation

// MARK: - Terminal UI Utilities

enum TerminalColor: String {
    case black = "\u{001B}[30m"
    case red = "\u{001B}[31m"
    case green = "\u{001B}[32m"
    case yellow = "\u{001B}[33m"
    case blue = "\u{001B}[34m"
    case magenta = "\u{001B}[35m"
    case cyan = "\u{001B}[36m"
    case white = "\u{001B}[37m"
    case bold = "\u{001B}[1m"
    case underline = "\u{001B}[4m"
    case brightRed = "\u{001B}[91m"
    case brightGreen = "\u{001B}[92m"
    case brightYellow = "\u{001B}[93m"
    case brightBlue = "\u{001B}[94m"
    case brightMagenta = "\u{001B}[95m"
    case brightCyan = "\u{001B}[96m"
    case brightWhite = "\u{001B}[97m"
}

enum BoardStyle {
    case classic
    case unicode
    case minimal
    
    var horizontal: String {
        switch self {
        case .classic: return "---------------"
        case .unicode: return "═══════════════"
        case .minimal: return "---------------"
        }
    }
    
    var vertical: String {
        switch self {
        case .classic: return "|"
        case .unicode: return "║"
        case .minimal: return "|"
        }
    }
    
    var corner: String {
        switch self {
        case .classic: return "+"
        case .unicode: return "╬"
        case .minimal: return "+"
        }
    }
}

class TerminalUI {
    static var boardStyle: BoardStyle = .unicode
    static var animationEnabled = true
    
    static func clearScreen() {
        print("\u{001B}[2J\u{001B}[;H", terminator: "")
        fflush(stdout)
    }
    
    static func colorText(_ text: String, color: TerminalColor) -> String {
        return "\(color.rawValue)\(text)\u{001B}[0m"
    }
    
    static func colorBackground(_ text: String, color: TerminalColor) -> String {
        let bgColorMap: [TerminalColor: String] = [
            .red: "\u{001B}[41m",
            .green: "\u{001B}[42m",
            .yellow: "\u{001B}[43m",
            .blue: "\u{001B}[44m",
            .magenta: "\u{001B}[45m",
            .cyan: "\u{001B}[46m",
            .white: "\u{001B}[47m",
            .brightRed: "\u{001B}[101m",
            .brightGreen: "\u{001B}[102m",
            .brightYellow: "\u{001B}[103m",
            .brightBlue: "\u{001B}[104m",
            .brightMagenta: "\u{001B}[105m",
            .brightCyan: "\u{001B}[106m",
            .brightWhite: "\u{001B}[107m"
        ]
        
        guard let bgColor = bgColorMap[color] else {
            return text
        }
        
        return "\(bgColor)\(text)\u{001B}[0m"
    }
    
    static func waitForEnter(prompt: String = "Appuyez sur Entrée pour continuer...") {
        print("\n" + colorText(prompt, color: .yellow))
        _ = readLine()
    }
    
    static func displayFramedText(_ texts: [String], frameColor: TerminalColor = .blue, plain: Bool = false) {
        let processedTexts = texts
        let plainTexts = processedTexts.map { $0.replacingOccurrences(of: "\\u\\{001B\\[[0-9;]*m", with: "", options: .regularExpression) }
        let maxLength = plainTexts.map { $0.count }.max() ?? 0
        let frameWidth = max(maxLength + 4, 40)
        
        let topBorder = String(repeating: "═", count: frameWidth)
        let bottomBorder = String(repeating: "═", count: frameWidth)
        
        print(colorText("╔" + topBorder + "╗", color: frameColor))
        for text in processedTexts {
            let plainText = text.replacingOccurrences(of: "\\u\\{001B\\[[0-9;]*m", with: "", options: .regularExpression)
            let paddingCount = frameWidth - plainText.count - 4
            let padding = String(repeating: " ", count: max(0, paddingCount))
            print(colorText("║ \(text)\(padding) ║", color: frameColor))
        }
        print(colorText("╚" + bottomBorder + "╝", color: frameColor))
        print()
    }
    
    static func displayAnimation(text: String, delay: TimeInterval = 0.03) {
        guard animationEnabled else {
            print(text)
            return
        }
        
        for char in text {
            print(char, terminator: "")
            fflush(stdout)
            Thread.sleep(forTimeInterval: delay)
        }
        print()
    }
    
    static func getInput(prompt: String, color: TerminalColor = .green) -> String {
        print(colorText(prompt, color: color), terminator: " ")
        return readLine() ?? ""
    }
    
    static func displayMenu(title: String, options: [String]) -> Int {
        clearScreen()
        displayFramedText([colorText(title, color: .bold)], frameColor: .cyan)
        
        for (index, option) in options.enumerated() {
            print(colorText("  \(index + 1). \(option)", color: .white))
        }
        
        print()
        var selection = 0
        while selection < 1 || selection > options.count {
            let input = getInput(prompt: "Entrez votre choix (1-\(options.count)):", color: .yellow)
            if let choice = Int(input), choice >= 1, choice <= options.count {
                selection = choice
            } else {
                print(colorText("Choix invalide. Veuillez entrer un nombre entre 1 et \(options.count).", color: .red))
            }
        }
        
        return selection - 1
    }
} 