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

import Foundation
import UIKit

enum Type: CaseIterable {
    case human
    case cat
    case dog
    case bird
    case fish
    case koala
    
    var name: String {
        switch self {
        case .human: return "Human"
        case .cat: return "Cat"
        case .dog: return "Dog"
        case .bird: return "Bird"
        case .fish: return "Fish"
        case .koala: return "Koala"
        }
    }
    
    var cost: Int {
        switch self {
        case .human: return 100
        case .cat: return 2000
        case .dog: return 25_000
        case .bird: return 30_000
        case .fish: return 320_000
        case .koala: return 4_000_000
        }
    }
    
    var earning: Int {
        switch self {
        case .human: return 1
        case .cat: return 10
        case .dog: return 100
        case .bird: return 150
        case .fish: return 500
        case .koala: return 1000
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
    
    var background: UIImage {
        switch self {
        case .human: return #imageLiteral(resourceName: "background")
        case .cat, .dog, .bird, .fish, .koala: return #imageLiteral(resourceName: "grass")
        }
    }
}
