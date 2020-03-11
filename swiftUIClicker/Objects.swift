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

class Object: ObservableObject, CustomStringConvertible {
    @Published var strenght: Int
    
    init(strenght: Int) {
        self.strenght = strenght
    }
    
    var description: String {
        return "\(strenght)"
    }
}

class ObjectType: ObservableObject, CustomStringConvertible {
    var type: Type
    
    @Published var objects: [Object] = []
    
    init(type: Type) {
        self.type = type
    }
    
    var description: String {
        let objValues = objects.map {$0.description}.joined(separator: ", ")
        return "Type: \(type.name), object count: \(objects.count) values: \(objValues)"
    }
    
    func canBuy(with coins: Int) -> Bool {
        coins >= type.cost
    }
    
}

class Game: ObservableObject {
    
    @Published var objects: [ObjectType] = [
        ObjectType(type: .human),
        ObjectType(type: .cat)
    ]
    
    @Published var coins: Int = 0
    
    var unusedTypes = Type.allCases.filter {$0 != .human && $0 != .cat}
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.objects.forEach { (objectType) in
                
                objectType.objects.forEach { (object) in
                    self.addCoin(value: objectType.type.earning / 10)
                }
                
            }
        }
    }
    
    func add(objectForType type: Type) {
        
        guard let objectType = objects.first(where: {$0.type == type}) else {
            return
        }
        
        guard objectType.objects.count < 10 else { return }
        
        guard coins >= objectType.type.cost else { return }
        
        coins -= objectType.type.cost
        
        objectType.objects.append(Object(strenght: objectType.type.earning))
        objectWillChange.send()
        
        if objectType.objects.count == 10 {
            addNewType()
        }
    }
    
    func addNewType() {
        guard let first = unusedTypes.first else {
            return
        }
        
        objects.append(ObjectType(type: first))
        
        unusedTypes.remove(at: 0)
    }
    
    func addCoin(value: Int = 1) {
        guard coins < Int.max else { return }
        coins += value
    }
    
}
