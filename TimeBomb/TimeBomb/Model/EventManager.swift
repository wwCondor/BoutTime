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

// Custom type struct/classes

// Need function to randomly populate events for each round
// No events are mutlplied in same round of play

// Event may be repated during game, although not inside round
// A 60 second timer end autochecks events for correctness
// Device shake pre-ends round and checks events for correctness



class EventManager {
    
    struct Events {
        let eventName: String
        let eventDate: Int
    }
    
    // this needs to hold at least 25 events, but 40+ recommended
    //
    // the eventDate holds date as integer value
    // These now hold some sample Events to test everything
    
    let eventOne = Events (eventName: "Birth of Jasper", eventDate: 19871030)
    let eventTwo = Events (eventName: "Birth of Wouter", eventDate: 19840915)
    let eventThree = Events (eventName: "Birth of Martijn", eventDate: 19810415)
    let eventFour = Events (eventName: "Birth of Kim", eventDate: 19810518 )
    let eventFive = Events (eventName: "Birth of Nika", eventDate: 20180501)
    
    let eventsPerRound = 4
    let roundsPerGame = 6
    
    var roundsCompleted = 0
    var roundsSortedCorrectly = 0
    
    var eventsCombined = [Events]()
    var eventsArrayForRound: [Events] = []
    
    
    init() {
        self.eventsCombined = [eventOne, eventTwo, eventThree, eventFour, eventFive]
    }
    
    // This randomizes the order of events without generating duplicates per round
    // The Events are stored in eventsArrayForRound
    func eventArrayProvider(){
        let randomEventArray = GKShuffledDistribution.init(lowestValue: 0, highestValue: eventsCombined.count - 1)
        for _  in 1...eventsPerRound {
            eventsArrayForRound.append(eventsCombined[randomEventArray.nextInt()])
            print(eventsArrayForRound)
        }
    }
    // At this point I have an array with 4 unique events
    
    // Theses methods provide the events for the four eventFields
    // Find a way to combine these into one method -> DRY!
    // Get rid of 'magic numbers'
    func provideEventForFieldOne() -> Events {
        eventArrayProvider()
        let eventsReturned = eventsArrayForRound[0]
        return eventsReturned
    }
    
    func provideEventForFieldTwo() -> Events {
        eventArrayProvider()
        let eventsReturned = eventsArrayForRound[1]
        return eventsReturned
    }
    
    func provideEventForFieldThree() -> Events {
        eventArrayProvider()
        let eventsReturned = eventsArrayForRound[2]
        return eventsReturned
    }
    
    func provideEventForFieldFour() -> Events {
        eventArrayProvider()
        let eventsReturned = eventsArrayForRound[3]
        return eventsReturned
    }
    
    // This empties the eventsArray when next round is started
    func emptyEventsArray() {
        eventsArrayForRound.removeAll()
    }
    
    // This resets all game data and removes events frrom array
    func resetGameData() {
        roundsCompleted = 0
        roundsSortedCorrectly = 0
        eventsArrayForRound.removeAll()
    }

    
    // If roundsCompleted == 6 this method should end the game
    func checkIfGameIsOver() {
        
    }
    
}
