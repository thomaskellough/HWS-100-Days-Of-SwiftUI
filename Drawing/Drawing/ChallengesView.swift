//
//  ChallengesView.swift
//  Drawing
//
//  Created by Thomas Kellough on 9/16/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import SwiftUI

struct ChallengesView: View {
    let baseWidth: CGFloat = 100
    let baseHeight: CGFloat = 200
    let arrowWidth: CGFloat = 200
    let arrowHeight: CGFloat = 100
    
    @State private var lineWidth: CGFloat = 1.0
    
    
    var body: some View {
        VStack {
            Arrow(baseWidth: baseWidth, baseHeight: baseHeight, arrowWidth: arrowWidth, arrowHeight: arrowHeight)
                .stroke(Color.red, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .onTapGesture {
                    withAnimation(.linear(duration: 3)) {
                        self.lineWidth = 15.0
                    }
                }
        }
    }
}

struct ChallengesView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengesView()
    }
}
struct Arrow: Shape {
    let baseWidth: CGFloat
    let baseHeight: CGFloat
    let arrowWidth: CGFloat
    let arrowHeight: CGFloat
    let arrowGap: CGFloat
    
    var baseGap: CGFloat
    var totalHeight: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        
        // Rectangular Base
        path.move(to: CGPoint(x: baseGap, y: totalHeight))
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width - baseGap, y: totalHeight))
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width - baseGap, y: totalHeight - baseHeight))
        path.move(to: CGPoint(x: baseGap, y: totalHeight - baseHeight))
        path.addLine(to: CGPoint(x: baseGap, y: totalHeight))
        path.move(to: CGPoint(x: baseGap, y: totalHeight - baseHeight))
        
        // Triangle Top
        path.addLine(to: CGPoint(x: arrowGap, y: baseHeight))
        path.addLine(to: CGPoint(x: arrowGap + (0.5 * arrowWidth), y: arrowHeight))
        path.addLine(to: CGPoint(x: arrowGap + arrowWidth, y: baseHeight))
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width - baseGap, y: totalHeight - baseHeight))
        
        return path
    }
    
    init(baseWidth: CGFloat, baseHeight: CGFloat, arrowWidth: CGFloat, arrowHeight: CGFloat) {
        self.baseWidth = baseWidth
        self.baseHeight = baseHeight
        self.baseGap = (UIScreen.main.bounds.width - baseWidth) / 2
        
        self.arrowWidth = arrowWidth
        self.arrowHeight = arrowHeight
        self.arrowGap = (UIScreen.main.bounds.width - arrowWidth) / 2
        
        self.totalHeight = baseHeight + arrowHeight * 2
    }
}
