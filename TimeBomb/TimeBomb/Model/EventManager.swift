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
    
    // this needs to hold at least 25 events, but 40+ recommended
    // These now hold some sample Events to test everything
    // Possible topics: Star Trek, Art History Periods/paintings, mountain ascends
    let events = [
        Event (eventName: "Birth of Jasper", eventDate: 19871030),
        Event (eventName: "Birth of Wouter", eventDate: 19840915),
        Event (eventName: "Birth of Martijn", eventDate: 19810415),
        Event (eventName: "Birth of Kim", eventDate: 19820518 ),
        Event (eventName: "Birth of Nika", eventDate: 20180501)
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
            // print(eventsArrayForRound)
        }
    }
    
    
    func isOrderOfEventsCorrect() -> Bool {
        // let viewController = ViewController.init()
        // nextRoundButton.isHidden = false
        var isCorrectOrder = false
        if eventsArrayForRound[0].eventDate >
            eventsArrayForRound[1].eventDate
            &&
            eventsArrayForRound[1].eventDate >
            eventsArrayForRound[2].eventDate
            &&
            eventsArrayForRound[2].eventDate >
            eventsArrayForRound[3].eventDate {
            
            // viewController.instructionsLabel.text = "Well done!"
            roundsSortedCorrect += 1
            Soundmanager.loadGameCorrectDing()
            Soundmanager.playGameCorrectDing()
            isCorrectOrder = true
        } else {
            // viewController.instructionsLabel.text = "Woops! Wrong Order"
            Soundmanager.loadGameIncorrectBuzz()
            Soundmanager.playGameIncorrectBuzz()
        }
        endRound()
        // viewController.showNextRoundButtonOrDisplayScore()
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
