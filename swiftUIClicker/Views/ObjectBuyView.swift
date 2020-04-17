//  
//  ObjectBuyView.swift
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

struct ObjectBuyView: View {
    @EnvironmentObject var game: Game
    var objectType: CoinGeneratorContainer
    @State var showInfo: Bool = false
    
    var body: some View {
        HStack(spacing: 0) {
            BuyButton(action: {
                self.game.add(objectForType: self.objectType.type)
                SoundManager.shared.play(.buy)
            }, objectType: objectType)
                .frame(width: 120)
                .disabled(!objectType.canBuy(with: self.game.coins))
                .opacity(objectType.canBuy(with: self.game.coins) ? 1.0 : 0.5)
             
            ZStack(alignment: .leading) {
                
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.blue)
                    
                    Rectangle()
                        .fill(Color.green)
                }
                
                Circle()
                    .fill(Color.yellow)
                    .frame(width: 20, height: 20, alignment: .leading)
                    .padding(.bottom, 120)
                    .padding(.leading, 50)
                
                ScrollView(.horizontal) {
                    
                    HStack(spacing: 0) {
                        ForEach(0..<objectType.objects.count, id: \.self, content: { _ in
                            Image(uiImage: self.objectType.type.image)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(.top, 10)
                        })
                    }
                    
                }
            }
        }
    }
}
