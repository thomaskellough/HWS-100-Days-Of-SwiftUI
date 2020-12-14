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
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                
                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: self.width * 0.75, height: height * 0.75)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                    self.feedback.prepare()
                }
                
                .onEnded { _ in
                    if abs(self.offset.width) > 100 {
                        if self.offset.width < 0 {
                            self.feedback.notificationOccurred(.error)
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
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
