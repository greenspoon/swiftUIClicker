//  
//  Constants.swift
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

struct Constants {
    
    static let isDebugOn = true
    
    struct Human {
        static let cost: Int = 100
        static let earning = 1
        static let name = "Human"
    }
    
    struct Cat {
        static let cost = 2000
        static let earning = 10
        static let name = "Cat"
    }
    
    struct Dog {
        static let cost = 25_000
        static let earning = 100
        static let name = "Dog"
    }
    
    struct Bird {
        static let cost = 30_000
        static let earning = 150
        static let name = "Bird"
    }
    
    struct Fish {
        static let cost = 320_000
        static let earning = 500
        static let name = "Fish"
    }
    
    struct Koala {
        static let cost = 4_000_000
        static let earning = 1000
        static let name = "Koala"
    }
    
}
