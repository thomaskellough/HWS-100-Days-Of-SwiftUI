//
//  ContentView.swift
//  Animations
//
//  Created by Thomas Kellough on 8/24/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var rows = 100
    @State private var columns = 100
    
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var amount: CGFloat = 1.0
    @State private var hue = 0.6
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
                .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                .frame(width: 300, height: 300)
            
            Spacer()
            
            Group {
                Text("Inner radius: \(Int(innerRadius))")
                Slider(value: $innerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])

                Text("Outer radius: \(Int(outerRadius))")
                Slider(value: $outerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])

                Text("Distance: \(Int(distance))")
                Slider(value: $distance, in: 1...150, step: 1)
                    .padding([.horizontal, .bottom])

                Text("Amount: \(amount, specifier: "%.2f")")
                Slider(value: $amount)
                    .padding([.horizontal, .bottom])

                Text("Color")
                Slider(value: $hue)
                    .padding(.horizontal)
            }
        }
        //        Checkerboard(rows: rows, columns: columns)
        //            .onTapGesture {
        //                withAnimation(.linear(duration: 3)) {
        //                    self.rows = 200
        //                    self.columns = 200
        //                }
        //            }
    }
}

struct Spirograph: Shape {
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let amount: CGFloat
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        
        return a
    }
    
    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)
        let outerRadius = CGFloat(self.outerRadius)
        let innerRadius = CGFloat(self.innerRadius)
        let distance = CGFloat(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * CGFloat.pi * outerRadius / CGFloat(divisor)) * amount
        
        var path = Path()
        
        for theta in stride(from: 0, to: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)
            
            x += rect.width / 2
            y += rect.height / 2
            
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        return path
    }
}

//struct ContentView: View {
//
//    @State private var animationAmount = 0.0
//    @State private var enabled = false
//
//    @State private var dragAmount = CGSize.zero
//
//    @State private var isShowingRed = false
//
//    @State private var colorCycle = 0.0
//
//    @State private var amount: CGFloat = 0.0
//
//    let letters = Array("Hello SwiftUI")
//
//    @State private var insetAmount: CGFloat = 50
//
//    @State private var rows = 4
//    @State private var columns = 4
//
//    var body: some View {
//
//        Checkerboard(rows: rows, columns: columns)
//            .onTapGesture {
//                withAnimation(.linear(duration: 3)) {
//                    self.rows = 8
//                    self.columns = 16
//                }
//            }
//    }
//}

//        Trapezoid(insetAmount: insetAmount)
//            .frame(width: 200, height: 100)
//            .onTapGesture {
//                self.insetAmount = CGFloat.random(in: 10...90)
//        }

//        VStack {
//            ZStack {
//                Circle()
//                    .fill(Color(red: 1, green: 0, blue: 0))
//                    .frame(width: 200 * amount)
//                    .offset(x: -50, y: -80)
//                    .blendMode(.screen)
//
//                Circle()
//                    .fill(Color(red: 0, green: 1, blue: 0))
//                    .frame(width: 200 * amount)
//                    .offset(x: 50, y: -80)
//                    .blendMode(.screen)
//
//                Circle()
//                    .fill(Color(red: 0, green: 0, blue: 1))
//                    .frame(width: 200 * amount)
//                    .blendMode(.screen)
//            }
//            .frame(width: 300, height: 300)
//
//            Image("lion")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 200, height: 200)
//                .saturation(Double(amount))
//                .blur(radius: (1 - amount) * 20)
//
//            Slider(value: $amount)
//                .padding()

//            ZStack {
//                GeometryReader { geo in
//                    Image("lion")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: geo.size.width)
//                }
//
//                Rectangle()
//                    .fill(Color.red)
//                    .blendMode(.multiply)
//            }
//
//            GeometryReader { geo in
//                Image("lion")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: geo.size.width)
//                    .colorMultiply(.green)
//            }
//
//            ColorCyclingCircle(amount: self.colorCycle)
//                .frame(width: 300, height: 300)
//
//            Slider(value: $colorCycle)
//
//            Button("Tap Me") {
//                withAnimation {
//                    self.isShowingRed.toggle()
//                }
//            }
//
//            if isShowingRed {
//                Rectangle()
//                    .fill(Color.red)
//                    .frame(width: 200, height: 200)
//                    .transition(.pivot)
//                //                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
//                //                    .transition(.pivot)
//            }

//            HStack(spacing: 0) {
//                ForEach(0..<letters.count) { num in
//                    Text(String(self.letters[num]))
//                        .padding(5)
//                        .font(.title)
//                        .background(self.enabled ? Color.blue : Color.red)
//                        .offset(self.dragAmount)
//                        .animation(Animation.default.delay(Double(num) / 20))
//                }
//            }
//            .gesture(
//                DragGesture()
//                    .onChanged { self.dragAmount = $0.translation }
//                    .onEnded { _ in
//                        self.dragAmount = .zero
//                        self.enabled.toggle()
//                }
//            )
//
//            LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                .frame(width: 300, height: 200)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
//                .offset(dragAmount)
//                .gesture(
//                    DragGesture()
//                        .onChanged { self.dragAmount = $0.translation }
//                        .onEnded {  _ in
//                            withAnimation(.spring()) {
//                                self.dragAmount = .zero
//                            }
//                        }
//                )
//                .animation(.spring())




//            Button("Flip Y") {
//                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
//                    self.animationAmount += 360
//                }
//            }
//            .styleButton(color: Color.red)
//            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
//            .padding()
//
//            Button("Flip X") {
//                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
//                    self.animationAmount += 360
//                }
//            }
//            .styleButton(color: Color.blue)
//            .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 0, z: 0))
//            .padding()
//
//            Button("Flip Z") {
//                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
//                    self.animationAmount += 360
//                }
//            }
//            .styleButton(color: Color.green)
//            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 0, z: 1))
//            .padding()
//
//            Button("Color Change") {
//                self.enabled.toggle()
//            }
//            .frame(width: 200, height: 200)
//            .styleButtonStack(color: enabled ? Color.yellow : Color.purple)
//            .animation(.default)
//            .foregroundColor(.black)
//            .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
//            .animation(.interpolatingSpring(stiffness: 10, damping: 1))
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.black)
//        .edgesIgnoringSafeArea(.all)
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}

// Custom View Modifier for Explicit Animations
struct ButtonStyle: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .padding(50)
            .background(color)
            .foregroundColor(.white)
            .clipShape(Circle())
    }
}

extension View {
    func styleButton(color: Color) -> some View {
        self.modifier(ButtonStyle(color: color))
    }
}

// CustomView Modifer for Animation Stack
struct ButtonStyleStack: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .padding(50)
            .background(color)
            .foregroundColor(.white)
    }
}

extension View {
    func styleButtonStack(color: Color) -> some View {
        self.modifier(ButtonStyleStack(color: color))
    }
}

struct CornerRotateModifer: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifer(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifer(amount: 0, anchor: .topLeading)
        )
    }
}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Trapezoid: Shape {
    var insetAmount: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}

struct Checkerboard: Shape {
    var rows: Int
    var columns: Int
    
    public var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }
        
        set {
            self.rows = Int(newValue.first)
            self.columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // figure out how big each row/column needs to be
        let rowSize = rect.height / CGFloat(rows)
        let columnSize = rect.width / CGFloat(columns)
        
        // loop over all rows and columns, making alternating squares colored
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    // this square should be colored; add a rectangle here
                    let startX = columnSize * CGFloat(column)
                    let startY = rowSize * CGFloat(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
}
