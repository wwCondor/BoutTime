//
//  File.swift
//  TimeBomb
//
//  Created by Wouter Willebrands on 08/01/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//
import UIKit
import Foundation
import AudioToolbox

class PlayCorrectDingSound {
    
    static var gameSound: SystemSoundID = 0
    
    static func loadGameCorrectDing() {
        let path = Bundle.main.path(forResource: "CorrectDing", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    static func playGameCorrectDing() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
}

class PlayBuzzerSound {
    
    static var gameSound: SystemSoundID = 0
    
    static func loadGameIncorrectBuzz() {
        let path = Bundle.main.path(forResource: "IncorrectBuzz", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    static func playGameIncorrectBuzz() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
}

