//  
//  Type.swift
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

import UIKit

enum CoinGeneratorType: Int, CaseIterable {
    case human
    case cat
    case dog
    case bird
    case fish
    case koala
    
    var name: String {
        switch self {
        case .human: return Constants.Human.name
        case .cat: return Constants.Cat.name
        case .dog: return Constants.Dog.name
        case .bird: return Constants.Bird.name
        case .fish: return Constants.Fish.name
        case .koala: return Constants.Koala.name
        }
    }
    
    var cost: Int {
        switch self {
        case .human: return Constants.Human.cost
        case .cat: return Constants.Cat.cost
        case .dog: return Constants.Dog.cost
        case .bird: return Constants.Bird.cost
        case .fish: return Constants.Fish.cost
        case .koala: return Constants.Koala.cost
        }
    }
    
    var earning: Int {
        switch self {
        case .human: return Constants.Human.earning
        case .cat: return Constants.Cat.earning
        case .dog: return Constants.Dog.earning
        case .bird: return Constants.Bird.earning
        case .fish: return Constants.Fish.earning
        case .koala: return Constants.Koala.earning
        }
    }
    
    var image: UIImage {
        switch self {
        case .human: return #imageLiteral(resourceName: "human")
        case .cat: return #imageLiteral(resourceName: "cat")
        case .dog: return #imageLiteral(resourceName: "dog")
        case .bird: return #imageLiteral(resourceName: "bird")
        case .fish: return #imageLiteral(resourceName: "fish")
        case .koala: return #imageLiteral(resourceName: "koala")
        }
    }
    
}
