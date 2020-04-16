//  
//  ObjectType.swift
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

class CoinGeneratorContainer: Identifiable, ObservableObject, CustomStringConvertible {
    
    var id = UUID()
    var type: CoinGeneratorType
    var objectTypeIsUnlocked: ObjectTypeIsUnlocked?
    
    @Published var objects: [Object] = []
    @Published var isLocked: Bool = true {
        didSet {
            if oldValue != isLocked {
                self.objectTypeIsUnlocked?.objectType(self, isLocked: self.isLocked)
            }
        }
    }
    
    init(type: CoinGeneratorType) {
        self.type = type
    }
    
    var earnPerSecond: Int {
        type.earning * objects.count
    }
    
    var description: String {
        let objValues = objects.map {$0.description}.joined(separator: ", ")
        return "Type: \(type.name), object count: \(objects.count) values: \(objValues)"
    }
    
    func canBuy(with coins: Int) -> Bool {
        let canBuy = coins >= type.cost +
        if canBuy {
            isLocked = false
        }
        return canBuy
    }
    
}

