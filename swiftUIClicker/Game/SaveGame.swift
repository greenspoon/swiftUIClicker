//  
//  SaveGame.swift
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

import Foundation

struct ObjectWrapper: Codable {
    var strenght: Int
}

struct CoinGeneratorContainerCodableWrapper: Codable {
    
    var id: UUID
    var type: Int
    var isLocked: Bool
    var objects: [ObjectWrapper]
    
    static func wrapper(from container: CoinGeneratorContainer) -> CoinGeneratorContainerCodableWrapper {
        let objectWrapped = container.objects.map {ObjectWrapper(strenght: $0.strenght) }
        let wrapper = CoinGeneratorContainerCodableWrapper(id: container.id, type: container.type.rawValue, isLocked: container.isLocked, objects: objectWrapped)
        return wrapper
    }
    
    func container() -> CoinGeneratorContainer? {
        let wrapper = self
        
        guard let type = CoinGeneratorType(rawValue: wrapper.type) else {
            return nil
        }
        
        let objecs = wrapper.objects.map { Object(strenght: $0.strenght)}
        let container = CoinGeneratorContainer(type: type)
        
        container.id = wrapper.id
        container.isLocked = wrapper.isLocked
        container.objects = objecs
        
        
        return container
    }
    
}

class SaveGameStatus {
    
    enum PropertyType: String {
        case coinGeneratorContainers
        case coinsToBeAdded
        case coins
        case unusedTypes
        case minusCoinValue
    }
    
    static func save(_ game: Game) {
        
        let wrappedGeneratorContainers = game.coinGeneratorContainers.compactMap { CoinGeneratorContainerCodableWrapper.wrapper(from: $0) }
        
        if let data = try? PropertyListEncoder().encode(wrappedGeneratorContainers) {
            save(data, .coinGeneratorContainers)
        }
        
        save(game.coinsToBeAdded, .coinsToBeAdded)
        save(game.coins, .coins)
        
        let rawUnusedTypes = game.unusedTypes.map {$0.rawValue}
        
        save(rawUnusedTypes, .unusedTypes)
        save(game.minusCoinValue, .minusCoinValue)
        
    }
    
    private static func save(_ value: Any, _ type: PropertyType) {
        UserDefaults.standard.set(value, forKey: type.rawValue)
    }
    
    private static func read(_ type: PropertyType) -> Any? {
        UserDefaults.standard.object(forKey: type.rawValue)
    }
    
    static func get() -> Game {
        let game = Game()
        
        if let containerData = read(.coinGeneratorContainers) as? Data,
            let coinGeneratorContainersWrappers = try? PropertyListDecoder().decode([CoinGeneratorContainerCodableWrapper].self, from: containerData) {
            let containers: [CoinGeneratorContainer] = coinGeneratorContainersWrappers.compactMap ({ wrapper in
               let container = wrapper.container()
                container?.objectTypeIsUnlocked = game
                return container
            })
            
            game.coinGeneratorContainers = containers
            
        }
        
        game.coinsToBeAdded = read(.coinsToBeAdded) as? Int ?? 0
        game.coins = read(.coins) as? Int ?? 0
        
        if let unusedTypes = (read(.unusedTypes) as? [Int])?.compactMap({CoinGeneratorType(rawValue: $0)}) {
            game.unusedTypes = unusedTypes
        }
        
        game.minusCoinValue = read(.minusCoinValue) as? Int ?? 0
        
        
        return game
    }
    
}
