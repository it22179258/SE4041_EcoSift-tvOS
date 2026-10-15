# EcoSift Arena — tvOS Recycling Education Game

SE4041 — Mobile Application Design and Development 
Assignment 02 — Part B: Innovative tvOS Application

Tagline: Sort Smart. Play Together. Save the Planet.

1. Project Overview

EcoSift Arena is an interactive recycling education game developed for Apple TV using Swift and SwiftUI. It provides an engaging way for individuals, families, and students to learn about common waste materials through television-based gameplay.

The application is designed specifically for tvOS and uses focus-based navigation to allow players to interact using an Apple TV remote.

EcoSift Arena complements the EcoSift iOS application by extending recycling education to a shared television experience.

2. Problem Statement

Understanding how to separate waste materials is important for responsible waste management. However, conventional educational content may not always provide opportunities for interactive group participation.

EcoSift Arena addresses this challenge through a simple and accessible television-based learning game where users identify waste materials, receive educational feedback, and compete through score-based challenges.

3. Key Features

Solo Challenge
- Single-player recycling classification game.
- Five waste identification questions.
- Five selectable waste material categories.
- Immediate feedback after every answer.
- Ten points awarded for each correct answer.
- Final results with a replay option.

Two-Player Challenge
- Local two-player gameplay using a shared remote.
- Ten total questions with alternating player turns.
- Five questions per player.
- Independent scoring for Player 1 and Player 2.
- Automatic winner or tie announcement.
- Replay and Main Menu navigation.

TV-Based Interaction
- Apple TV remote-compatible focus navigation.
- Large buttons designed for television viewing.
- Clear focus highlighting.
- Keyboard arrow and Enter key support in the Apple TV simulator.
- Accessible visual feedback and readable typography.

Visual Design
- Custom dark-green nature-themed background.
- Consistent environmental branding.
- Focus animations and highlighted selection states.
- Material icons, progress indicators, and score cards.

4. Supported Waste Categories

EcoSift Arena contains five waste material categories:

1. Plastic
2. Glass
3. Metal
4. Paper
5. Cardboard

The game uses predefined educational examples such as bottles, food cans, newspapers, and shipping boxes.

The classification questions are intended for material recognition education. Local recycling requirements may vary.

5. Technologies Used

| Technology | Purpose |

| Swift | Application programming |
| SwiftUI | User interface development |
| tvOS | Apple TV platform |
| @State | Gameplay and scoring state management |
| @FocusState | Apple TV focus navigation |
| SF Symbols | Interface iconography |
| Xcode | Development and debugging |
| Apple TV Simulator | Application testing |

6. Application Flow

**Welcome Screen → Game Mode Selection → Waste Sorting Challenge → Answer Feedback → Next Question → Final Results → Replay or Main Menu**

The gameplay is implemented using SwiftUI state management.

In Solo mode, the game consists of five rounds.

In Two-Player mode, players alternate turns over ten rounds, and their scores are calculated independently.

7. Scoring System

- Correct answer: +10 points.
- Incorrect answer: 0 points.
- Only the first answer for each question is scored.
- Solo maximum score: 50 points.
- Two-player maximum score: 50 points per player.

At the end of a two-player game, the application compares both players' scores and displays the winner or a tie.

8. Installation and Setup

Requirements

- A Mac capable of running a compatible version of Xcode.
- Xcode with tvOS development support.
- An installed Apple TV simulator runtime.

Build Instructions

1. Clone or download this GitHub repository.
2. Open the `EcoSiftArena.xcodeproj` project in Xcode.
3. Select the `EcoSiftArena` application scheme.
4. Select an available Apple TV simulator as the run destination.
5. Press **Command + B** to build the project.
6. Press **Command + R** to launch the application.

Running the Game

1. Launch EcoSift Arena in the Apple TV simulator.
2. Select Solo Challenge or Two Players.
3. Use the remote or simulator arrow keys to navigate.
4. Press Select or Enter to choose an answer.
5. Review the feedback and select Next Item.
6. Complete all rounds to view the final results.
7. Select Play Again or Main Menu.

9. Project Structure

- `EcoSiftArena.xcodeproj` — Xcode project configuration.
- `EcoSiftArena/ContentView.swift` — Game screens, questions, scoring, focus navigation, and gameplay logic.
- `EcoSiftArena/EcoSiftArenaApp.swift` — tvOS application entry point.
- `EcoSiftArena/Assets.xcassets` — Application assets and custom background.
- `README.md` — Project documentation.
- `.gitignore` — Git exclusion rules.

10. Testing

The prototype was manually tested in the Apple TV 4K simulator.

Verified functionality includes:

- Welcome screen and mode selection.
- Remote-style navigation using keyboard controls.
- Solo gameplay and scoring.
- Correct and incorrect answer feedback.
- Two-player alternating turns.
- Independent player scores.
- Final result and winner calculation.
- Replay and return-to-menu functionality.
- Custom nature-themed background rendering.

Testing was conducted using the simulator. Physical Apple TV device testing has not been confirmed.

11. Innovation and Target Audience

EcoSift Arena introduces a shared-screen learning experience focused on waste material recognition.

Target users:
- Families and children.
- Schools and educational institutions.
- Environmental education programs.
- Museums and community learning spaces.

The application's main value lies in combining television-based interaction, recycling education, and local multiplayer competition.

12. Proposed Business Model

The future commercial concept includes:

- A free basic version for household learning.
- Educational content packs and potential school licensing.
- Partnerships with environmental organizations.
- Expanded classroom and community learning experiences.

These are proposed future business opportunities and are not currently implemented commercial features.

13. Future Improvements

- Additional waste material categories.
- New question packs and difficulty levels.
- More detailed educational content.
- Expanded multiplayer functionality.
- Persistent high scores and achievement tracking.
- More visual waste-item illustrations.
- Classroom-oriented learning activities.

14. Limitations

The current application is a functional educational prototype. It uses predefined questions and does not use machine learning for waste identification. It does not include online multiplayer, cloud synchronization, or persistent score storage.


15. Conclusion

EcoSift Arena demonstrates the development of a native tvOS educational game using SwiftUI and Apple TV interaction principles.

The completed prototype supports solo and local two-player waste sorting challenges, scoring, immediate educational feedback, and results visualization.

The project demonstrates how television-based interaction can be used to create an engaging shared learning experience focused on environmental awareness.

---

Module: SE4041 — Mobile Application Design and Development  
Assignment: Assignment 02 — Part B  
Platform: tvOS  
Development Language: Swift  
Framework: SwiftUI