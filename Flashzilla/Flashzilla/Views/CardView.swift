//
//  CardView.swift
//  Flashzilla
//
//  Created by Thomas Kellough on 12/14/20.
//

import SwiftUI

struct CardView: View {
    // Accessibility
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    // Get screen height to adjust card size for all devices
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    
    // Gesture variables
    @State private var offset = CGSize.zero
    
    // Haptic feedback
    @State private var feedback = UINotificationFeedbackGenerator()
    
    @State private var isShowingAnswer = false
    let card: Card
    var removal: (() -> Void)? = nil
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? Color.white
                        : Color.white
                            .opacity(1 - Double(abs(offset.width / 50))))
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(offset.width > 0 ? Color.green : Color.red)
                )
                .shadow(radius: 10)
            
            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }                    
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: self.width * 0.75, height: height * 0.75)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibility(addTraits: .isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                    self.feedback.prepare()
                }
                
                .onEnded { _ in
                    if abs(self.offset.width) > 100 {
                        if self.offset.width < 0 {
                            // Player did not get answer correct
                            self.feedback.notificationOccurred(.error)
                            var tryAgainDictionary: [String: String] = [:]
                            if let savedDictonary = UserDefaults.standard.dictionary(forKey: "tryAgainCards") as? [String: String] {
                                tryAgainDictionary = savedDictonary
                            }
                            
                            tryAgainDictionary[card.prompt] = card.answer
                            UserDefaults.standard.setValue(tryAgainDictionary, forKey: "tryAgainCards")
                        } else {
                            // Player did get answer correct
                            var correct = UserDefaults.standard.integer(forKey: "currentScore")
                            correct += 1
                            UserDefaults.standard.setValue(correct, forKey: "currentScore")
                        }

                        self.removal?()
                    } else {
                        self.offset = .zero
                    }
                }
        )
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
        .animation(.spring())
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
