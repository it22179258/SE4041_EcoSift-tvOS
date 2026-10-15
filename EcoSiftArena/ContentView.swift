import SwiftUI

// MARK: - Game Screens

private enum ArenaScreen {
    case welcome
    case playing
    case results
}

// MARK: - Game Modes

private enum ArenaGameMode: Hashable {
    case solo
    case twoPlayers

    var title: String {
        switch self {
        case .solo:
            return "Solo Challenge"
        case .twoPlayers:
            return "Two Players"
        }
    }

    var rounds: Int {
        switch self {
        case .solo:
            return 5
        case .twoPlayers:
            return 10
        }
    }

    var symbol: String {
        switch self {
        case .solo:
            return "person.fill"
        case .twoPlayers:
            return "person.2.fill"
        }
    }
}

// MARK: - Waste Categories

private enum ArenaMaterial: String, CaseIterable, Identifiable {

    case plastic = "Plastic"
    case glass = "Glass"
    case metal = "Metal"
    case paper = "Paper"
    case cardboard = "Cardboard"

    var id: String {
        rawValue
    }

    var symbol: String {
        switch self {
        case .plastic:
            return "waterbottle.fill"
        case .glass:
            return "wineglass.fill"
        case .metal:
            return "circle.grid.2x2.fill"
        case .paper:
            return "doc.fill"
        case .cardboard:
            return "shippingbox.fill"
        }
    }

    var color: Color {
        switch self {
        case .plastic:
            return .blue
        case .glass:
            return .teal
        case .metal:
            return .gray
        case .paper:
            return .orange
        case .cardboard:
            return .brown
        }
    }
}

// MARK: - Waste Question

private struct ArenaQuestion {

    let item: String
    let emoji: String
    let correctMaterial: ArenaMaterial
    let explanation: String
}

// MARK: - EcoSift Arena

struct ContentView: View {

    // MARK: - Game State

    @State private var screen: ArenaScreen = .welcome
    @State private var gameMode: ArenaGameMode = .solo

    @State private var roundIndex = 0
    @State private var selectedAnswer: ArenaMaterial?

    @State private var playerOneScore = 0
    @State private var playerTwoScore = 0

    // MARK: - TV Remote Focus

    @FocusState private var focusedMode: ArenaGameMode?
    @FocusState private var focusedMaterial: ArenaMaterial?

    // MARK: - Theme

    private let darkGreen = Color(
        red: 0.035,
        green: 0.12,
        blue: 0.10
    )

    private let primaryGreen = Color(
        red: 0.13,
        green: 0.55,
        blue: 0.34
    )

    private let lightGreen = Color(
        red: 0.40,
        green: 0.88,
        blue: 0.58
    )

    // MARK: - Questions

    private let questions: [ArenaQuestion] = [

        ArenaQuestion(
            item: "Empty Shampoo Bottle",
            emoji: "🧴",
            correctMaterial: .plastic,
            explanation:
                "Shampoo bottles are commonly made from plastic."
        ),

        ArenaQuestion(
            item: "Glass Drink Bottle",
            emoji: "🍾",
            correctMaterial: .glass,
            explanation:
                "Glass bottles belong to the glass material category."
        ),

        ArenaQuestion(
            item: "Metal Food Can",
            emoji: "🥫",
            correctMaterial: .metal,
            explanation:
                "Food cans are commonly made from steel or aluminium."
        ),

        ArenaQuestion(
            item: "Old Newspaper",
            emoji: "📰",
            correctMaterial: .paper,
            explanation:
                "Newspapers are classified as paper waste."
        ),

        ArenaQuestion(
            item: "Shipping Box",
            emoji: "📦",
            correctMaterial: .cardboard,
            explanation:
                "Shipping boxes are commonly made from cardboard."
        ),

        ArenaQuestion(
            item: "Plastic Detergent Bottle",
            emoji: "🧴",
            correctMaterial: .plastic,
            explanation:
                "Many detergent bottles are made from plastic."
        ),

        ArenaQuestion(
            item: "Notebook Paper",
            emoji: "📄",
            correctMaterial: .paper,
            explanation:
                "Notebook sheets belong to the paper category."
        ),

        ArenaQuestion(
            item: "Aluminium Food Tin",
            emoji: "🥫",
            correctMaterial: .metal,
            explanation:
                "Aluminium containers belong to the metal category."
        ),

        ArenaQuestion(
            item: "Glass Beverage Bottle",
            emoji: "🍾",
            correctMaterial: .glass,
            explanation:
                "This bottle is made from glass."
        ),

        ArenaQuestion(
            item: "Flattened Cardboard Box",
            emoji: "📦",
            correctMaterial: .cardboard,
            explanation:
                "Cardboard packaging belongs to the cardboard category."
        )
    ]

    // MARK: - Current Question

    private var currentQuestion: ArenaQuestion {
        questions[roundIndex]
    }

    // MARK: - Current Player

    private var currentPlayer: Int {
        gameMode == .solo ? 1 : (roundIndex % 2) + 1
    }

    // MARK: - Main UI

    var body: some View {

        ZStack {

            // MARK: - Fallback Background

            // Keeps the original green background
            // if the image cannot be loaded.

            LinearGradient(
                colors: [
                    darkGreen,
                    Color(
                        red: 0.06,
                        green: 0.23,
                        blue: 0.18
                    ),
                    darkGreen
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .allowsHitTesting(false)

            // MARK: - NEW: Nature Background Image

            GeometryReader { geometry in

                Image("ArenaBackground")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
                    .clipped()
                    .accessibilityHidden(true)
            }
            .ignoresSafeArea()
            .allowsHitTesting(false)

            // MARK: - NEW: Dark Readability Overlay

            // Change 0.48 to 0.30 if the
            // background looks too dark.

            Color.black
                .opacity(0.25)
                .ignoresSafeArea()
                .allowsHitTesting(false)

            // MARK: - Game Content

            ScrollView {

                VStack(spacing: 32) {

                    // MARK: - App Branding

                    headerView

                    if screen == .welcome {

                        welcomeScreen

                    } else if screen == .playing {

                        gameScreen

                    } else {

                        resultsScreen
                    }
                }
                .frame(maxWidth: 1550)
                .padding(.horizontal, 45)
                .padding(.vertical, 35)
                .frame(maxWidth: .infinity)
            }
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - App Header

    private var headerView: some View {

        HStack(spacing: 16) {

            Image(systemName: "leaf.fill")
                .font(.system(size: 38))
                .foregroundStyle(lightGreen)

            Text("EcoSift Arena")
                .font(.system(size: 38, weight: .bold))
                .foregroundStyle(.white)

            Spacer()

            Text("SORT SMART. PLAY TOGETHER.")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white.opacity(0.65))
        }
    }

    // MARK: - Welcome Screen

    private var welcomeScreen: some View {

        VStack(spacing: 30) {

            Image(systemName: "arrow.3.trianglepath")
                .font(.system(size: 90))
                .foregroundStyle(lightGreen)
                .padding(.top, 30)

            Text("Sort Smart. Play Together.")
                .font(.system(size: 54, weight: .bold))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)

            Text(
                "Learn how to identify everyday waste materials in an interactive Apple TV challenge."
            )
            .font(.system(size: 24))
            .foregroundStyle(.white.opacity(0.75))
            .multilineTextAlignment(.center)
            .frame(maxWidth: 950)

            Text("CHOOSE YOUR GAME MODE")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(lightGreen)
                .padding(.top, 15)

            HStack(spacing: 35) {

                modeButton(.solo)

                modeButton(.twoPlayers)
            }

            Text(
                "Use your Apple TV remote to move between options and press Select."
            )
            .font(.system(size: 19))
            .foregroundStyle(.white.opacity(0.60))
            .padding(.top, 12)
        }
        .padding(35)
    }

    // MARK: - Game Mode Button

    private func modeButton(
        _ mode: ArenaGameMode
    ) -> some View {

        Button {

            startGame(mode)

        } label: {

            VStack(spacing: 17) {

                Image(systemName: mode.symbol)
                    .font(.system(size: 52))
                    .foregroundStyle(lightGreen)

                Text(mode.title)
                    .font(.system(size: 30, weight: .bold))

                Text(
                    mode == .solo
                        ? "5 waste items"
                        : "10 items · Alternating turns"
                )
                .font(.system(size: 19))
                .foregroundStyle(.white.opacity(0.75))
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 230)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        focusedMode == mode
                            ? primaryGreen
                            : Color.white.opacity(0.10)
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(
                        focusedMode == mode
                            ? lightGreen
                            : Color.white.opacity(0.20),
                        lineWidth: 3
                    )
            )
        }
        .buttonStyle(.plain)
        .focused($focusedMode, equals: mode)
        .scaleEffect(
            focusedMode == mode ? 1.04 : 1.0
        )
        .animation(
            .easeOut(duration: 0.15),
            value: focusedMode
        )
    }

    // MARK: - Game Screen

    private var gameScreen: some View {

        VStack(spacing: 25) {

            // MARK: - Game Progress

            HStack {

                Text(
                    "ROUND \(roundIndex + 1) / \(gameMode.rounds)"
                )
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(lightGreen)

                Spacer()

                if gameMode == .twoPlayers {

                    Text("PLAYER \(currentPlayer)'S TURN")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundStyle(.yellow)

                } else {

                    Text("SOLO CHALLENGE")
                        .font(.system(size: 23, weight: .bold))
                        .foregroundStyle(.white)
                }
            }

            ProgressView(
                value: Double(roundIndex + 1),
                total: Double(gameMode.rounds)
            )
            .tint(lightGreen)

            // MARK: - Scores

            HStack(spacing: 20) {

                scoreCard(
                    title: gameMode == .solo
                        ? "Your Score"
                        : "Player 1",
                    score: playerOneScore
                )

                if gameMode == .twoPlayers {

                    scoreCard(
                        title: "Player 2",
                        score: playerTwoScore
                    )
                }
            }

            // MARK: - Waste Item Card

            VStack(spacing: 15) {

                Text("IDENTIFY THIS WASTE MATERIAL")
                    .font(.system(size: 21, weight: .semibold))
                    .foregroundStyle(lightGreen)

                Text(currentQuestion.emoji)
                    .font(.system(size: 90))

                Text(currentQuestion.item)
                    .font(.system(size: 42, weight: .bold))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)

                Text("Which category does it belong to?")
                    .font(.system(size: 22))
                    .foregroundStyle(.white.opacity(0.75))
            }
            .frame(maxWidth: .infinity)
            .padding(28)
            .background(
                Color.white.opacity(0.07),
                in: RoundedRectangle(cornerRadius: 26)
            )

            // MARK: - Answers

            HStack(spacing: 15) {

                ForEach(ArenaMaterial.allCases) { material in

                    answerButton(material)
                }
            }

            // MARK: - Feedback

            if let selectedAnswer {

                VStack(spacing: 13) {

                    Label(
                        selectedAnswer == currentQuestion.correctMaterial
                            ? "Correct! +10 Points"
                            : "Not Quite!",
                        systemImage:
                            selectedAnswer == currentQuestion.correctMaterial
                            ? "checkmark.circle.fill"
                            : "xmark.circle.fill"
                    )
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(
                        selectedAnswer == currentQuestion.correctMaterial
                            ? lightGreen
                            : .orange
                    )

                    Text(currentQuestion.explanation)
                        .font(.system(size: 20))
                        .foregroundStyle(.white)

                    if selectedAnswer != currentQuestion.correctMaterial {

                        Text(
                            "Correct answer: \(currentQuestion.correctMaterial.rawValue)"
                        )
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(lightGreen)
                    }

                    Button {

                        nextRound()

                    } label: {

                        Label(
                            roundIndex == gameMode.rounds - 1
                                ? "View Results"
                                : "Next Item",
                            systemImage: "arrow.right.circle.fill"
                        )
                        .font(.system(size: 23, weight: .bold))
                        .padding(.horizontal, 35)
                        .padding(.vertical, 14)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(primaryGreen)
                }
                .padding(15)
            }

            Button("Exit to Main Menu") {
                screen = .welcome
            }
            .font(.system(size: 19))
            .foregroundStyle(.white.opacity(0.75))
        }
    }

    // MARK: - Score Card

    private func scoreCard(
        title: String,
        score: Int
    ) -> some View {

        HStack(spacing: 16) {

            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)

            Text(title)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.white)

            Text("\(score)")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(lightGreen)
        }
        .frame(maxWidth: .infinity)
        .padding(14)
        .background(
            Color.white.opacity(0.09),
            in: RoundedRectangle(cornerRadius: 17)
        )
    }

    // MARK: - Answer Button

    private func answerButton(
        _ material: ArenaMaterial
    ) -> some View {

        Button {

            chooseAnswer(material)

        } label: {

            VStack(spacing: 15) {

                Image(systemName: material.symbol)
                    .font(.system(size: 35))
                    .foregroundStyle(
                        focusedMaterial == material
                            ? lightGreen
                            : .white
                    )

                Text(material.rawValue)
                    .font(.system(size: 23, weight: .bold))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 155)
            .background(
                answerColor(for: material),
                in: RoundedRectangle(cornerRadius: 20)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        focusedMaterial == material
                            ? lightGreen
                            : Color.white.opacity(0.15),
                        lineWidth:
                            focusedMaterial == material ? 5 : 2
                    )
            )
        }
        .buttonStyle(.plain)
        .focused(
            $focusedMaterial,
            equals: material
        )
        .scaleEffect(
            focusedMaterial == material ? 1.04 : 1.0
        )
        .animation(
            .easeOut(duration: 0.15),
            value: focusedMaterial
        )
    }

    // MARK: - Answer Background

    private func answerColor(
        for material: ArenaMaterial
    ) -> Color {

        if let selectedAnswer {

            if material == currentQuestion.correctMaterial {
                return Color.green.opacity(0.45)
            }

            if selectedAnswer == material {
                return Color.red.opacity(0.45)
            }
        }

        if focusedMaterial == material {
            return primaryGreen
        }

        return Color.white.opacity(0.11)
    }

    // MARK: - Results Screen

    private var resultsScreen: some View {

        VStack(spacing: 30) {

            Image(systemName: "trophy.fill")
                .font(.system(size: 100))
                .foregroundStyle(.yellow)

            Text(
                gameMode == .solo
                    ? "Challenge Complete!"
                    : winnerText
            )
            .font(.system(size: 50, weight: .bold))
            .foregroundStyle(.white)

            Text("FINAL RESULTS")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(lightGreen)

            HStack(spacing: 35) {

                scoreCard(
                    title: gameMode == .solo
                        ? "Your Score"
                        : "Player 1",
                    score: playerOneScore
                )

                if gameMode == .twoPlayers {

                    scoreCard(
                        title: "Player 2",
                        score: playerTwoScore
                    )
                }
            }
            .frame(maxWidth: 1000)

            Text(
                "Great work! Keep learning how to sort waste responsibly."
            )
            .font(.system(size: 23))
            .foregroundStyle(.white.opacity(0.75))
            .multilineTextAlignment(.center)

            HStack(spacing: 25) {

                Button {

                    startGame(gameMode)

                } label: {

                    Label(
                        "Play Again",
                        systemImage: "arrow.clockwise"
                    )
                    .font(.system(size: 24, weight: .bold))
                    .padding(20)
                }
                .buttonStyle(.borderedProminent)
                .tint(primaryGreen)

                Button {

                    screen = .welcome

                } label: {

                    Label(
                        "Main Menu",
                        systemImage: "house.fill"
                    )
                    .font(.system(size: 24, weight: .bold))
                    .padding(20)
                }
                .buttonStyle(.bordered)
            }

            Text(
                "EcoSift Arena teaches material recognition. Actual recycling rules vary by location."
            )
            .font(.system(size: 17))
            .foregroundStyle(.white.opacity(0.55))
            .padding(.top, 20)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 45)
    }

    // MARK: - Winner

    private var winnerText: String {

        if playerOneScore > playerTwoScore {
            return "Player 1 Wins!"
        }

        if playerTwoScore > playerOneScore {
            return "Player 2 Wins!"
        }

        return "It's a Tie!"
    }

    // MARK: - Start Game

    private func startGame(
        _ mode: ArenaGameMode
    ) {

        gameMode = mode

        roundIndex = 0
        selectedAnswer = nil

        playerOneScore = 0
        playerTwoScore = 0

        screen = .playing
        focusedMaterial = .plastic
    }

    // MARK: - Choose Answer

    private func chooseAnswer(
        _ material: ArenaMaterial
    ) {

        // Only score the first answer for each question.
        guard selectedAnswer == nil else {
            return
        }

        selectedAnswer = material

        if material == currentQuestion.correctMaterial {

            if currentPlayer == 1 {
                playerOneScore += 10
            } else {
                playerTwoScore += 10
            }
        }
    }

    // MARK: - Next Round

    private func nextRound() {

        if roundIndex < gameMode.rounds - 1 {

            roundIndex += 1
            selectedAnswer = nil
            focusedMaterial = .plastic

        } else {

            screen = .results
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
