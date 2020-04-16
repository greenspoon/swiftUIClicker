//  
//  Objects.swift
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

protocol ObjectTypeIsUnlocked: class {
    func objectType(_ objectType: CoinGeneratorContainer, isLocked: Bool)
}

class Object: ObservableObject, CustomStringConvertible {
    @Published var strenght: Int
    
    init(strenght: Int) {
        self.strenght = strenght
    }
    
    var description: String {
        return "\(strenght)"
    }
}
