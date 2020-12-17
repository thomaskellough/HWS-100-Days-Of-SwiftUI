//
//  RollView.swift
//  Milestone 16-18 DiceRoller
//
//  Created by Thomas Kellough on 12/16/20.
//

import SwiftUI

struct RollView: View {
    let diceOptions = ["dice_1", "dice_2", "dice_3", "dice_4", "dice_5", "dice_6"]
    let width = UIScreen.main.bounds.size.width / 2
    let height = UIScreen.main.bounds.size.width / 2
    
    @State private var numberOfDice = 2
    @State private var rolledDice = [String]()
    @State private var total = 0
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationView {
            VStack {
                ForEach(0..<Int(ceil(Double((rolledDice.count / 2))))) { index in
                    DiceView(dice1: rolledDice[index], dice2: rolledDice[rolledDice.count - index + 1])
                }
                
                Text("Total: \(total)")
                    .padding()
                
                Spacer()
                Button(action: {
                    self.roll()
                }, label: {
                    Text("Roll")
                        .font(.title)
                })
                .padding()
                .frame(width: width)
                .background(Color.green)
                .foregroundColor(Color.white)
                .clipShape(Capsule())
            }
            .padding()
            .onAppear(perform: {
                self.roll(saveToCoreData: false)
            })
            .navigationBarTitle("Roll")
        }
    }
    
    func roll(saveToCoreData: Bool = true) {
        var diceArray = [String]()
        numberOfDice = UserDefaults.standard.integer(forKey: "numberOfDice")
        self.total = 0
        
        for _ in 0..<numberOfDice {
            let randomDice = diceOptions.randomElement() ?? "dice_1"
            diceArray.append(randomDice)
            
            let numberString = randomDice.split(separator: "_")[1]
            if let number = Int(numberString) {
                self.total += number
            }
        }
        
        self.rolledDice = diceArray
        
        if saveToCoreData {
            saveRoll()
        }
    }
    
    func saveRoll() {
        let roll = Roll(context: self.moc)
        roll.total = Int16(self.total)
        roll.date = Date()
        
        let stringArray: String = self.rolledDice.description
        let dataArray = stringArray.data(using: String.Encoding.utf16)
        roll.rolls = dataArray
        
        try? self.moc.save()
    }
    
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}

struct DiceView: View {
    let dice1: String
    let dice2: String?
    let width: CGFloat = 100
    let height: CGFloat = 100
    
    var body: some View {
        HStack {
            Image(dice1)
                .resizable()
                .frame(width: width, height: height)
            dice2 != nil
                ? Image(dice2!)
                    .resizable()
                    .frame(width: width, height: height)
                : nil
        }
    }
}
