//  
//  InformationOverlayView.swift
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

struct InformationOverlayView: View {
    
    @Binding var showing: Bool
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }.background(Color.black)
    }
}

struct InformationOverlayView_Previews: PreviewProvider {
    
    static var previews: some View {
        InformationOverlayView(showing: .constant(true))
    }
    
}
