//  
//  BuyButton.swift
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

struct BuyButton: View {
    var action: () -> Void
    var objectType: CoinGeneratorContainer
    
    var body: some View {
        
        Button(action: {
            self.action()
            
        }, label: {
            VStack(spacing: 0) {
                
                Image(uiImage: objectType.type.image)
                    .renderingMode(objectType.isLocked ? .template : .original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                Text("\(objectType.type.cost) €").font(.system(Font.TextStyle.headline))
                if !objectType.isLocked {
                    Text("\(objectType.type.earning)x\(objectType.objects.count)=\(objectType.earnPerSecond)").font(Font.system(size: 12)).foregroundColor(Color.gray)
                }
            }
            .padding()
            .foregroundColor(Color.black)
            .background(Color.yellow)
        })
        
    }
    
}
