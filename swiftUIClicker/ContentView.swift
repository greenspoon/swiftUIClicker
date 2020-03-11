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
    
    @ObservedObject var game: Game
    
    var body: some View {
        VStack {
            Text(game.coins.description)
            
            CircleButton {
                self.game.addCoin()
            }
            
            ScrollView(.vertical) {
                VStack {
                    ForEach(game.objects, id: \.type.name, content: { obj in
                        HStack {
                            Button(action: {
                                self.game.add(objectForType: obj.type)
                            }, label: {
                                VStack {
                                    Text(obj.type.name)
                                    Text("Cost: \(obj.type.cost)")
                                    Text("Earning: \(obj.type.earning)")
                                    Text("count: \(obj.objects.count)")
                                }
                                .padding()
                                .background(Color.yellow)
                                .foregroundColor(Color.black)
                                .border(Color.black, width: 2)
                                .cornerRadius(4)
                            })
                                .disabled(!obj.canBuy(with: self.game.coins))
                                .opacity(obj.canBuy(with: self.game.coins) ? 1.0 : 0.5)
                            ScrollView(.horizontal) {
                                HStack(spacing: 0) {
                                    ForEach(0..<obj.objects.count, id: \.self, content: { _ in
                                        ZStack {
                                            Image(uiImage: obj.type.background).resizable().frame(width: 100, height: 100)
                                            Image(uiImage: obj.type.image)
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .padding(.top, 10)
                                        }
                                    })
                                }
                            }
                        }
                    })
                }
            }
            
        }.padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(game: Game())
    }
}


