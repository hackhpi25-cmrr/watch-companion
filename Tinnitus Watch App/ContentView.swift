import SwiftUI
import WatchKit

// Main ContentView with TabView for navigation
struct ContentView: View {
    var body: some View {
        TabView {
            DistractionGamesView()
                .tabItem {
                    Label("Games", systemImage: "gamecontroller.fill")
                }
            
            RelaxationView()
                .tabItem {
                    Label("Relax", systemImage: "heart.fill")
                }
            
            EarCareView()
                .tabItem {
                    Label("Care", systemImage: "ear.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .navigationTitle("Tinnitus Relief")
    }
}

// Distraction Games View
struct DistractionGamesView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: BreathingGameView()) {
                    GameRowView(title: "Breathing Focus", icon: "lungs.fill", color: .blue)
                }
                

                
                NavigationLink(destination: TapPatternView()) {
                    GameRowView(title: "Tap Patterns", icon: "hand.tap.fill", color: .orange)
                }
                
                NavigationLink(destination: ColorPuzzleView()) {
                    GameRowView(title: "Color Puzzle", icon: "puzzlepiece.fill", color: .green)
                }
            }
            .navigationTitle("Games")
        }
    }
}

// Relaxation Techniques View
struct RelaxationView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: GuidedMeditationView()) {
                    TechniqueRowView(title: "Guided Meditation", icon: "brain.head.profile", color: .blue)
                }
                

                
                NavigationLink(destination: ProgressiveRelaxationView()) {
                    TechniqueRowView(title: "Progressive Relaxation", icon: "person.fill", color: .indigo)
                }
            }
            .navigationTitle("Relax")
        }
    }
}

// Ear & Jaw Care View
struct EarCareView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: JawExercisesView()) {
                    TechniqueRowView(title: "TMJ Exercises", icon: "mouth.fill", color: .pink)
                }
                
                NavigationLink(destination: MassageTechniquesView()) {
                    TechniqueRowView(title: "Ear Massage", icon: "hand.raised.fill", color: .orange)
                }
                
                NavigationLink(destination: StretchingView()) {
                    TechniqueRowView(title: "Neck Stretches", icon: "figure.mind.and.body", color: .green)
                }
                
                NavigationLink(destination: TinnitusTipsView()) {
                    TechniqueRowView(title: "Daily Tips", icon: "lightbulb.fill", color: .yellow)
                }
            }
            .navigationTitle("Care")
        }
    }
}

// Settings View
struct SettingsView: View {
    @State private var enableReminders = true
    @State private var enableHaptics = true
    @State private var selectedSoundType = "White Noise"
    let soundTypes = ["White Noise", "Pink Noise", "Brown Noise", "Nature Sounds"]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Notifications")) {
                    Toggle("Daily Reminders", isOn: $enableReminders)
                    Toggle("Haptic Feedback", isOn: $enableHaptics)
                }
                
                Section(header: Text("Sound Preferences")) {
                    Picker("Background Sound", selection: $selectedSoundType) {
                        ForEach(soundTypes, id: \.self) { sound in
                            Text(sound)
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AboutView()) {
                        Label("About & Help", systemImage: "questionmark.circle")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

// Helper Views
struct GameRowView: View {
    var title: String
    var icon: String
    var color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 30))
                .frame(width: 40, height: 40)
            
            Text(title)
                .fontWeight(.medium)
        }
        .padding(.vertical, 8)
    }
}

struct TechniqueRowView: View {
    var title: String
    var icon: String
    var color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 30))
                .frame(width: 40, height: 40)
            
            Text(title)
                .fontWeight(.medium)
        }
        .padding(.vertical, 8)
    }
}

// Game Detail Views
struct BreathingGameView: View {
    @State private var breatheIn = false
    @State private var count = 0
    let maxCount = 5
    let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text(breatheIn ? "Breathe In" : "Breathe Out")
                .font(.title3)
                .fontWeight(.bold)
            
            Circle()
                .fill(Color.blue.opacity(0.3))
                .frame(width: 100, height: 100)
                .overlay(
                    Circle()
                        .stroke(Color.blue, lineWidth: 4)
                        .scaleEffect(breatheIn ? 1.0 : 0.5)
                        .animation(.easeInOut(duration: 4), value: breatheIn)
                )
            
            Text("\(count)/\(maxCount)")
                .padding(.top)
        }
        .onReceive(timer) { _ in
            withAnimation {
                breatheIn.toggle()
                if !breatheIn {
                    count += 1
                }
            }
        }
        .navigationTitle("Breathing")
    }
}



struct TapPatternView: View {
    @State private var pattern = [Int.random(in: 1...4), Int.random(in: 1...4), Int.random(in: 1...4)]
    @State private var userPattern: [Int] = []
    @State private var showingPattern = true
    @State private var patternIndex = 0
    @State private var score = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text(showingPattern ? "Watch Pattern" : "Repeat Pattern")
                .font(.headline)
            
            Text("Score: \(score)")
                .padding()
            
            if showingPattern {
                Circle()
                    .fill(patternIndex < pattern.count ? numberToColor(pattern[patternIndex]) : Color.gray.opacity(0.3))
                    .frame(width: 80, height: 80)
            } else {
                HStack(spacing: 15) {
                    ForEach(1...4, id: \.self) { number in
                        Button(action: {
                            tapNumber(number)
                        }) {
                            Circle()
                                .fill(numberToColor(number))
                                .frame(width: 40, height: 40)
                        }
                    }
                }
                
                Text("Taps: \(userPattern.count)/\(pattern.count)")
                    .padding(.top)
            }
        }
        .onReceive(timer) { _ in
            if showingPattern {
                patternIndex += 1
                if patternIndex >= pattern.count + 1 {
                    showingPattern = false
                    patternIndex = 0
                    userPattern = []
                }
            }
        }
        .navigationTitle("Tap Pattern")
    }
    
    private func numberToColor(_ number: Int) -> Color {
        switch number {
        case 1: return .red
        case 2: return .blue
        case 3: return .green
        case 4: return .yellow
        default: return .gray
        }
    }
    
    private func tapNumber(_ number: Int) {
        userPattern.append(number)
        
        // Check if pattern is complete
        if userPattern.count == pattern.count {
            if userPattern == pattern {
                // Success
                score += 1
                WKInterfaceDevice.current().play(.success)
                
                // New pattern with one more item
                pattern = (0..<3+min(score, 5)).map { _ in Int.random(in: 1...4) }
            } else {
                // Failure
                WKInterfaceDevice.current().play(.failure)
                score = max(0, score - 1)
            }
            
            // Reset for next round
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showingPattern = true
                patternIndex = 0
            }
        }
    }
}

struct ColorPuzzleView: View {
    @State private var colors: [Color] = [.red, .green, .blue, .yellow, .purple, .orange]
    @State private var targetColorIndex = 0
    @State private var shuffledColors: [Color] = []
    @State private var score = 0
    
    var body: some View {
        VStack {
            Text("Match this color:")
                .font(.headline)
            
            Rectangle()
                .fill(colors[targetColorIndex])
                .frame(width: 80, height: 40)
                .cornerRadius(8)
            
            Text("Score: \(score)")
                .padding()
            
            HStack(spacing: 10) {
                ForEach(0..<min(4, shuffledColors.count), id: \.self) { index in
                    Button(action: {
                        checkColor(index)
                    }) {
                        Rectangle()
                            .fill(shuffledColors[index])
                            .frame(width: 40, height: 40)
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            startNewRound()
        }
        .navigationTitle("Color Match")
    }
    
    private func startNewRound() {
        targetColorIndex = Int.random(in: 0..<colors.count)
        shuffledColors = colors.shuffled()
    }
    
    private func checkColor(_ index: Int) {
        if shuffledColors[index] == colors[targetColorIndex] {
            score += 1
            WKInterfaceDevice.current().play(.success)
        } else {
            WKInterfaceDevice.current().play(.failure)
        }
        startNewRound()
    }
}

// Relaxation Detail Views
struct GuidedMeditationView: View {
    @State private var timeRemaining = 300 // 5 minutes in seconds
    @State private var isActive = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text(timeString(from: timeRemaining))
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(.blue)
                .padding()
            
            Circle()
                .trim(from: 0, to: CGFloat(timeRemaining) / 300)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [.blue, .purple]),
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 8, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .frame(width: 100, height: 100)
                .padding()
                .animation(.linear, value: timeRemaining)
            
            Button(action: {
                isActive.toggle()
                if isActive {
                    WKInterfaceDevice.current().play(.start)
                } else {
                    WKInterfaceDevice.current().play(.stop)
                }
            }) {
                Text(isActive ? "Pause" : "Start")
                    .fontWeight(.semibold)
                    .padding(.horizontal)
            }
            .buttonStyle(.bordered)
            .tint(isActive ? .red : .green)
        }
        .onReceive(timer) { _ in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
                
                // Add haptic feedback every minute
                if timeRemaining % 60 == 0 {
                    WKInterfaceDevice.current().play(.notification)
                }
            } else {
                isActive = false
                WKInterfaceDevice.current().play(.success)
            }
        }
        .navigationTitle("Meditation")
    }
    
    private func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}


struct ProgressiveRelaxationView: View {
    @State private var currentStep = 0
    @State private var isActive = false
    @State private var timeRemaining = 15 // seconds per step
    
    let relaxationSteps = [
        "Focus on your feet. Tense them for 5 seconds, then relax.",
        "Move to your calves. Tense for 5 seconds, then relax.",
        "Tense your thighs for 5 seconds, then relax.",
        "Tense your abdomen for 5 seconds, then relax.",
        "Tense your chest for 5 seconds, then relax.",
        "Tense your hands for 5 seconds, then relax.",
        "Tense your arms for 5 seconds, then relax.",
        "Tense your shoulders for 5 seconds, then relax.",
        "Tense your neck for 5 seconds, then relax.",
        "Tense your face for 5 seconds, then relax.",
        "Feel complete relaxation throughout your body."
    ]
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Step \(currentStep + 1) of \(relaxationSteps.count)")
                .font(.headline)
                .padding(.top)
            
            Text(relaxationSteps[currentStep])
                .multilineTextAlignment(.center)
                .padding()
            
            Text("\(timeRemaining)s")
                .font(.system(.title, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            Button(action: {
                isActive.toggle()
                if isActive {
                    WKInterfaceDevice.current().play(.start)
                } else {
                    WKInterfaceDevice.current().play(.stop)
                }
            }) {
                Text(isActive ? "Pause" : "Start")
                    .fontWeight(.semibold)
            }
            .buttonStyle(.bordered)
            .tint(isActive ? .red : .green)
            .padding(.top)
        }
        .onReceive(timer) { _ in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
                
                // Haptic feedback at 5 seconds
                if timeRemaining == 5 {
                    WKInterfaceDevice.current().play(.notification)
                }
            } else {
                // Move to next step
                if currentStep < relaxationSteps.count - 1 {
                    currentStep += 1
                    timeRemaining = 15
                    WKInterfaceDevice.current().play(.click)
                } else {
                    // Exercise complete
                    isActive = false
                    WKInterfaceDevice.current().play(.success)
                }
            }
        }
        .navigationTitle("Relaxation")
    }
}

// Ear & Jaw Care Detail Views
struct JawExercisesView: View {
    @State private var currentExercise = 0
    @State private var timeRemaining = 30 // seconds per exercise
    @State private var isActive = false
    
    let exercises = [
        "Gently open and close your mouth: Open wide, then close slowly. Repeat.",
        "Move your jaw side to side: Shift jaw left to right slowly, 10 times.",
        "Jaw resistance: Place hand under chin, open mouth while providing gentle resistance.",
        "Tongue up: Push tongue against roof of mouth, open and close jaw.",
        "Chin tucks: Pull chin back creating a 'double chin' effect, hold 3 seconds."
    ]
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Exercise \(currentExercise + 1) of \(exercises.count)")
                .font(.headline)
                .padding(.top)
            
            Text(exercises[currentExercise])
                .multilineTextAlignment(.center)
                .padding()
            
            Text("\(timeRemaining)s")
                .font(.system(.title, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.pink)
            
            Button(action: {
                isActive.toggle()
                if isActive {
                    WKInterfaceDevice.current().play(.start)
                } else {
                    WKInterfaceDevice.current().play(.stop)
                }
            }) {
                Text(isActive ? "Pause" : "Start")
                    .fontWeight(.semibold)
            }
            .buttonStyle(.bordered)
            .tint(isActive ? .red : .green)
            .padding(.top)
        }
        .onReceive(timer) { _ in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
                
                // Haptic feedback reminders
                if timeRemaining % 10 == 0 {
                    WKInterfaceDevice.current().play(.notification)
                }
            } else {
                // Move to next exercise
                if currentExercise < exercises.count - 1 {
                    currentExercise += 1
                    timeRemaining = 30
                    WKInterfaceDevice.current().play(.click)
                } else {
                    // Exercises complete
                    isActive = false
                    WKInterfaceDevice.current().play(.success)
                }
            }
        }
        .navigationTitle("TMJ Exercises")
    }
}

struct MassageTechniquesView: View {
    @State private var currentTechnique = 0
    @State private var timeRemaining = 20 // seconds per technique
    @State private var isActive = false
    
    let techniques = [
        "Tragus Pull: Gently pull the tragus (the small pointed part of your ear) away from your head.",
        "Ear Lobe Massage: With thumb and index finger, gently massage earlobes in circular motions.",
        "Ear Base Massage: Press and massage around the base of the ear where it connects to the head.",
        "External Ear Canal: Place finger at entrance of ear canal, press gently and massage in circles.",
        "Full Ear Massage: Gently pinch around the outer rim of your ear, moving from top to bottom."
    ]
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Technique \(currentTechnique + 1) of \(techniques.count)")
                .font(.headline)
                .padding(.top)
            
            Text(techniques[currentTechnique])
                .multilineTextAlignment(.center)
                .padding()
            
            Text("\(timeRemaining)s")
                .font(.system(.title, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.orange)
            
            Button(action: {
                isActive.toggle()
                if isActive {
                    WKInterfaceDevice.current().play(.start)
                } else {
                    WKInterfaceDevice.current().play(.stop)
                }
            }) {
                Text(isActive ? "Pause" : "Start")
                    .fontWeight(.semibold)
            }
            .buttonStyle(.bordered)
            .tint(isActive ? .red : .green)
            .padding(.top)
        }
        .onReceive(timer) { _ in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
                
                // Haptic feedback
                if timeRemaining % 5 == 0 {
                    WKInterfaceDevice.current().play(.click)
                }
            } else {
                // Move to next technique
                if currentTechnique < techniques.count - 1 {
                    currentTechnique += 1
                    timeRemaining = 20
                    WKInterfaceDevice.current().play(.notification)
                } else {
                    // Techniques complete
                    isActive = false
                    WKInterfaceDevice.current().play(.success)
                }
            }
        }
        .navigationTitle("Ear Massage")
    }
}

struct StretchingView: View {
    @State private var currentStretch = 0
    @State private var timeRemaining = 15 // seconds per stretch
    @State private var isActive = false
    
    let stretches = [
        "Head Tilt: Tilt head towards shoulder, hold 15 seconds, then switch sides.",
        "Chin Tuck: Pull chin toward chest while keeping back straight. Hold for 15 seconds.",
        "Head Turn: Slowly turn head to look over shoulder, hold 15 seconds, then switch sides.",
        "Shoulder Roll: Roll shoulders forward 5 times, then backward 5 times.",
        "Jaw Release: Drop jaw completely open, then close slowly. Repeat 10 times."
    ]
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Stretch \(currentStretch + 1) of \(stretches.count)")
                .font(.headline)
                .padding(.top)
            
            Text(stretches[currentStretch])
                .multilineTextAlignment(.center)
                .padding()
            
            Text("\(timeRemaining)s")
                .font(.system(.title, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.green)
            
            Button(action: {
                isActive.toggle()
                if isActive {
                    WKInterfaceDevice.current().play(.start)
                } else {
                    WKInterfaceDevice.current().play(.stop)
                }
            }) {
                Text(isActive ? "Pause" : "Start")
                    .fontWeight(.semibold)
            }
            .buttonStyle(.bordered)
            .tint(isActive ? .red : .green)
            .padding(.top)
        }
        .onReceive(timer) { _ in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
                
                // Haptic feedback
                if timeRemaining == 5 {
                    WKInterfaceDevice.current().play(.notification)
                }
            } else {
                // Move to next stretch
                if currentStretch < stretches.count - 1 {
                    currentStretch += 1
                    timeRemaining = 15
                    WKInterfaceDevice.current().play(.click)
                } else {
                    // Stretches complete
                    isActive = false
                    WKInterfaceDevice.current().play(.success)
                }
            }
        }
        .navigationTitle("Neck Stretches")
    }
}

// About and Help View
struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Tinnitus Relief")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                Text("This app is designed to help manage tinnitus symptoms through distraction techniques, relaxation exercises, and ear & jaw care.")
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("Emergency Help")
                    .font(.headline)
                    .padding(.top, 10)
                    .padding(.bottom, 5)
                
                Text("If you experience sudden hearing loss or dramatic changes in tinnitus, contact your healthcare provider immediately.")
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("Version 1.0")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 10)
            }
            .padding()
        }
        .navigationTitle("About")
    }
}

struct TinnitusTipsView: View {
    let tips = [
        "Avoid caffeine and nicotine, which can make tinnitus worse.",
        "Use white noise or soft music to mask tinnitus, especially at night.",
        "Protect your ears from loud sounds with earplugs or noise-cancelling headphones.",
        "Practice stress management through meditation and relaxation techniques.",
        "Stay hydrated and maintain a healthy diet with adequate vitamins and minerals.",
        "Limit salt intake, which can affect fluid retention and tinnitus symptoms.",
        "Get enough sleep and maintain a consistent sleep schedule.",
        "Avoid silence - use background noise when in quiet environments.",
        "Try to limit use of NSAIDs and aspirin, which can worsen tinnitus for some people.",
        "Regular exercise helps improve blood circulation, which may help reduce tinnitus."
    ]
    
    var body: some View {
        List {
            ForEach(tips.indices, id: \.self) { index in
                HStack(alignment: .top) {
                    Text("\(index + 1).")
                        .font(.headline)
                        .foregroundColor(.yellow)
                    
                    Text(tips[index])
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle("Daily Tips")
    }
}
