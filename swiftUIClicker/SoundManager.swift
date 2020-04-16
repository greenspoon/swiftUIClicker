//  
//  SoundManager.swift
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
import AVFoundation

class SoundManager {
    
    enum Sound: String {
        case coin = "pickup"
        case receive = "received"
        case buy = "buy"
    }
    
    private init() {}
    
    static let shared = SoundManager()
    
    var avPlayer: AVPlayer?
    
    func play(_ sound: Sound) {
        guard let sound = Bundle.main.url(forResource: sound.rawValue, withExtension: "wav") else {
            return
        }
        
        avPlayer = AVPlayer(url: sound)
        avPlayer?.play()
    }
    
}
