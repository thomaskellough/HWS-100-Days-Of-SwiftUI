//
//  ContentView.swift
//  Flashzilla
//
//  Created by Thomas Kellough on 12/13/20.
//

import CoreHaptics
import SwiftUI

struct ContentView: View {
    // Accessibility
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    @State private var cards = [Card]()
    @State private var tryAgainCards = [Card]()
    @State private var isActive = true // used to show when app is in background or not
    @State private var timeRemaining = 100
    @State private var showingEditScreen = false
    @State private var gameOver = false
    
    @State private var engine: CHHapticEngine?
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.75)
                    )
                
                ZStack {
                    ForEach(0..<cards.count, id: \.self) {index in
                        CardView(card: self.cards[index]) {
                            withAnimation {
                                self.removeCard(at: index)
                                if cards.isEmpty {
                                    isActive = false
                                }
                            }
                        }
                        .stacked(at: index, in: self.cards.count)
                        .allowsHitTesting(index == self.cards.count - 1)
                        .accessibility(hidden: index < self.cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    VStack {
                        Text("Great job!")
                            .font(.title)
                        Text("Number correct: \(UserDefaults.standard.integer(forKey: "currentScore"))")
                            .font(.title2)
                        UserDefaults.standard.integer(forKey: "currentScore") > UserDefaults.standard.integer(forKey: "highScore") ? Text("You have a new high score!") : Text("You failed to beat your new high score of \(UserDefaults.standard.integer(forKey: "highScore"))")
                    }
                    .onAppear(perform: prepareHaptics)
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                    UserDefaults.standard.dictionary(forKey: "tryAgainCards") != nil ? Button("Try Again", action: tryAgain)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                        : nil
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || accessibilityEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            withAnimation {
                                self.removeCard(at: self.cards.count - 1)
                            }
                        }) {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer has being incorrect"))
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                self.removeCard(at: self.cards.count - 1)
                            }
                        }) {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark your answer as being correct."))
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard self.isActive else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.gameOver = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if self.cards.isEmpty == false {
                self.isActive = true                
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCards()
        }
        .onAppear(perform: resetCards)
    }
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        if index == 0 {
            self.gameOverHaptic()
        }
        cards.remove(at: index)
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        if UserDefaults.standard.integer(forKey: "currentScore") > UserDefaults.standard.integer(forKey: "highScore") {
            UserDefaults.standard.setValue(UserDefaults.standard.integer(forKey: "currentScore"), forKey: "highScore")
        }
        UserDefaults.standard.setValue(0, forKey: "currentScore")
        loadData()
    }
    
    func tryAgain() {
        timeRemaining = 100
        isActive = true
        if UserDefaults.standard.integer(forKey: "currentScore") > UserDefaults.standard.integer(forKey: "highScore") {
            UserDefaults.standard.setValue(UserDefaults.standard.integer(forKey: "currentScore"), forKey: "highScore")
        }
        var savedCards = [Card]()
        
        if let savedCardsDictionary = UserDefaults.standard.dictionary(forKey: "tryAgainCards") as? [String: String] {
            for (key, value) in savedCardsDictionary {
                let card = Card(prompt: key, answer: value)
                savedCards.append(card)
            }
            
            self.cards = savedCards
        } else {
            loadData()
        }
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Error creating haptics engine: \(error.localizedDescription)")
        }
    }
    
    func gameOverHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        let values: [Float] = [0, 1, 0.1, 0.9, 0.2, 0.8, 0.3, 0.7, 0.4, 0.6, 0.5, 0]
        var time: Float = 0
        for value in values {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: value)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: value)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: TimeInterval(time))
            time += 0.1
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
