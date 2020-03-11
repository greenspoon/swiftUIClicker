//  
//  CircleButton.swift
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

struct CircleButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            Circle()
                .foregroundColor(Color.green)
                .padding(.horizontal, 15.0)
        }).buttonStyle(CircleButtonStyle())
    }
}

struct CircleButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
            .scaleEffect(configuration.isPressed ? 0.4 : 1.0)
            .animation(Animation.easeInOut(duration: 0.5))
    }
}
