//
//  EventManager.swift
//  TimeBomb
//
//  Created by Wouter Willebrands on 28/01/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation
import UIKit
import GameKit

struct Event {
    let eventName: String
    let eventDate: Int
}

class EventManager {
    
    // Nostalgia galore! Games and console first releases. Yay!
    let events = [
        Event (eventName: "Magnavox Odyssey", eventDate: 19720901),
        Event (eventName: "Atari 2600", eventDate: 19770911),
        Event (eventName: "Nintendo (NES)", eventDate: 19830715),
        Event (eventName: "Game Boy", eventDate: 19890421),
        Event (eventName: "Super Nintendo (SNES)", eventDate: 19901121),
        Event (eventName: "Ninteno 64", eventDate: 19960623),
        Event (eventName: "Pong", eventDate: 19721129),
        Event (eventName: "Space Invaders", eventDate: 19780601),
        Event (eventName: "Pac-Man", eventDate: 19800522),
        Event (eventName: "Donkey Kong", eventDate: 19810709),
        Event (eventName: "Donkey Kong Jr.", eventDate: 19820901),
        Event (eventName: "Bomberman", eventDate: 19830701),
        Event (eventName: "Duck Hunt", eventDate: 19840421),
        Event (eventName: "Tetris", eventDate: 19840606),
        Event (eventName: "Super Mario Bros.", eventDate: 19850913),
        Event (eventName: "The Legend of Zelda", eventDate: 19860221),
        Event (eventName: "Bubble Bobble", eventDate: 19860801),
        Event (eventName: "Castlevania", eventDate: 19860926),
        Event (eventName: "Street Fighter", eventDate: 19870830),
        Event (eventName: "Final Fantasy", eventDate: 19871218),
        Event (eventName: "Super Mario Bros. 2", eventDate: 19881009),
        Event (eventName: "Super Mario Bros. 3", eventDate: 19881023),
        Event (eventName: "Super Mario Land", eventDate: 19890421),
        Event (eventName: "Teenage Mutant Ninja Turtles", eventDate: 19890512),
        Event (eventName: "Dr. Mario", eventDate: 19900727),
        Event (eventName: "Turtles: Fall of the Footclan", eventDate: 19900803),
        Event (eventName: "Super R-Type", eventDate: 19910901),
        Event (eventName: "Super Ghouls 'n Ghosts", eventDate: 19911004),
        Event (eventName: "Legend of Zelda: A link to the past", eventDate: 19911121),
        Event (eventName: "Super Mario Kart", eventDate: 19920827),
        Event (eventName: "Star Fox", eventDate: 19930221),
        Event (eventName: "The Lost Vikings", eventDate: 19930429),
        Event (eventName: "Super Mario All-Stars", eventDate: 19930714),
        Event (eventName: "Secret of Mana", eventDate: 19930806),
        Event (eventName: "Super Street Fighter II", eventDate: 19940624),
        Event (eventName: "Donkey Kong Country", eventDate: 19941121),
        Event (eventName: "Super Mario World 2: Yoshi's Island", eventDate: 19950801),
        Event (eventName: "Super Mario 64", eventDate: 19960623),
        Event (eventName: "Pokemon Red and Blue", eventDate: 19980928),
        Event (eventName: "Super Smash Bros.", eventDate: 19990121),
        Event (eventName: "Donkey Kong 64", eventDate: 19991122)
    ]
    
    let eventsPerRound: Int = 4
    let roundsPerGame: Int = 6
    
    var roundsCompleted: Int = 0
    var roundsSortedCorrect: Int = 0
    
    // This array holds the events for the round
    var eventsArrayForRound: [Event] = []
    
    // This randomizes the order of events without generating duplicates per round
    // The Events are stored in eventsArrayForRound
    func eventArrayProvider(){
        let randomEventArray = GKShuffledDistribution.init(lowestValue: 0, highestValue: events.count - 1)
        for _  in 1...eventsPerRound {
            eventsArrayForRound.append(events[randomEventArray.nextInt()])
        }
    }
    
    
    func isOrderOfEventsCorrect() -> Bool {
    
        var isCorrectOrder = false
        if eventsArrayForRound[0].eventDate >
            eventsArrayForRound[1].eventDate
            &&
            eventsArrayForRound[1].eventDate >
            eventsArrayForRound[2].eventDate
            &&
            eventsArrayForRound[2].eventDate >
            eventsArrayForRound[3].eventDate {
            
            roundsSortedCorrect += 1
            Soundmanager.loadGameCorrectDing()
            Soundmanager.playGameCorrectDing()
            isCorrectOrder = true
        } else {
            
            Soundmanager.loadGameIncorrectBuzz()
            Soundmanager.playGameIncorrectBuzz()
        }
        endRound()
        return isCorrectOrder
    }
    
    // MARK: - End Round
    // When round ends show next round button
    // Exceeds: Show ?-Buttons to call wiki Events
    func endRound() {
        roundsCompleted += 1
        eventsArrayForRound.removeAll()
    }
    
    
    // This empties the eventsArray when next round is started
    func emptyEventsArray() {
        eventsArrayForRound.removeAll()
    }
    
    // This resets all game data and removes events from array
    func resetGameData() {
        roundsCompleted = 0
        roundsSortedCorrect = 0
        eventsArrayForRound.removeAll()
    }

}
