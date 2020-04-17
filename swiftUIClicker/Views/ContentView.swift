//
//  ContentView.swift
//  swiftUIClicker
//
//  (c) Neofonie Mobile GmbH (2020)
//
//  This computer program is the sole property of Neofonie
//  Mobile GmbH (http://mobile.neofonie.de) and is protected
//  under the German Copyright Act (paragraph 69a UrhG).
//
//  All rights are reserved. Making copies, duplicating,
//  modifying, using or distributing this computer program
//  in any form, without prior written consent of Neofonie
//  Mobile GmbH, is prohibited.
//
//  Violation of copyright is punishable under the German
//  Copyright Act (paragraph 106 UrhG).
//
//  Removing this copyright statement is also a violation.

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var game: Game
    
    var coinValue: Int = 0
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .singleLine
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
            VStack {
                VStack {
                    Text(game.coins.description + " €")
                        .font(.system(size: 35))
                    CircleButton {
                        SoundManager.shared.play(.coin)
                        self.game.addCoin()
                    }
                }.padding().background(Color.clear)
                
                //This creates an inset which can't be configured
                //            List(self.game.objects) { object in
                //                ObjectBuyView(objectType: object)
                //            }
                
                //I had to do it like this
                List {
                    ForEach(self.game.coinGeneratorContainers) { object in
                        ObjectBuyView(objectType: object)
                            .listRowInsets(EdgeInsets())
                    }
                }
                .padding(.top, 100)
                
            }
            .background(
                Image("money")
                    .resizable()
                    .scaledToFill()
                    .blur(radius: 5)
                    .edgesIgnoringSafeArea(.all))
    }
    
}

let preview_game = Game()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(preview_game)
    }
}
