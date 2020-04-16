//  
//  Game.swift
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
import Combine
import Foundation

class Game: ObservableObject, ObjectTypeIsUnlocked {
    
    @Published var coinGeneratorContainers: [CoinGeneratorContainer] = [
        CoinGeneratorContainer(type: .human),
        CoinGeneratorContainer(type: .cat)
    ]
    
    var coinsToBeAdded: Int = 0
    
    @Published var coins: Int = 0
    
    var unusedTypes: [CoinGeneratorType] = CoinGeneratorType.allCases.filter {$0 != .human && $0 != .cat}
    var minusCoinValue: Int = 1
    var gameDispatchQueue: DispatchQueue!
    var addingDispatchQueue: DispatchQueue!
    
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    init() {
        
        gameDispatchQueue = DispatchQueue(label: "Game.Thread")
        
        registerBackgroundTask()
        
        gameDispatchQueue.async { [weak self] in
            
            while true {
                guard let strongSelf = self else { return }
                strongSelf.coinGeneratorContainers.forEach { (objectType) in
                    
                    objectType.objects.forEach { (object) in
                        strongSelf.coinsToBeAdded += objectType.type.earning
                    }
                    
                    if objectType.objectTypeIsUnlocked == nil {
                        objectType.objectTypeIsUnlocked = self
                    }
                }
                
                Thread.sleep(forTimeInterval: 1.0)
                SaveGameStatus.save(strongSelf)
            }
            
        }
        
        addingDispatchQueue = DispatchQueue(label: "Adding.Thead")
        
        addingDispatchQueue.async {
            while true {
                guard self.coinsToBeAdded > 0 else {
                    continue
                }
                
                self.minusCoinValue = max(self.coinsToBeAdded / 10, 1)
                
                print("coinsToBeAdded: \(self.coinsToBeAdded) minusValue: \(self.minusCoinValue)")
                
                self.coinsToBeAdded -= self.minusCoinValue
                
                DispatchQueue.main.async {
                    self.addCoin(value: self.minusCoinValue)
                }
                
                Thread.sleep(forTimeInterval: 0.05)
            }
        }
    }
    
    
    /// This function creates a dumb background task so the app can run in the background
    func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
        assert(backgroundTask != .invalid)
    }
    
    func endBackgroundTask() {
        print("Background task ended.")
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }
    
    func add(objectForType type: CoinGeneratorType) {
        
        guard let objectType = coinGeneratorContainers.first(where: {$0.type == type}) else {
            return
        }
        
        guard coins >= objectType.type.cost else { return }
        
        coins -= objectType.type.cost
        
        objectType.objects.append(Object(strenght: objectType.type.earning))
        objectWillChange.send()
    }
    
    func addNextCoinGeneratorContainer() {
        guard let first = unusedTypes.first else {
            return
        }
        
        coinGeneratorContainers.append(CoinGeneratorContainer(type: first))
        
        unusedTypes.remove(at: 0)
        
    }
    
    func addCoin(value: Int = 1) {
        guard coins < Int.max else {
            print("YOU ARE OUT OF NUMBERS!!!!")
            return
        }
        coins += value
    }
    
    func objectType(_ objectType: CoinGeneratorContainer, isLocked: Bool) {
        if isLocked == false {
            addNextCoinGeneratorContainer()
            SoundManager.shared.play(.receive)
        }
    }
    
}
