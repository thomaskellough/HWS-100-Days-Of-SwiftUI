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
        VStack {
            Text("Rolling")
                .padding()
            
            ForEach(rolledDice, id: \.self) { dice in
                Image(dice)
                    .resizable()
                    .frame(width: width, height: height)
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
        .onAppear(perform: roll)
    }
    
    func roll() {
        var diceArray = [String]()
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
        saveRoll()
    }
    
    func saveRoll() {
        let roll = Roll(context: self.moc)
        roll.total = Int16(self.total)
        
        let stringArray: String = self.rolledDice.description
        let dataArray = stringArray.data(using: String.Encoding.utf16)
        roll.rolls = dataArray
        
        try? self.moc.save()
        //        let arrayBack: [String] = try! JSONDecoder().decode([String].self, from: dataArray!)
    }
    
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
