//
//  ViewController.swift
//  TimeBomb
//
//  Created by Wouter Willebrands on 08/01/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // This needs to display correctly on iPhone screen sies of 4.7 and 5.5 inches
    
    // MARK: Timerdata
    // timerForRound in current state gives problem
    var timerForRound: Timer!
    var secondsPerRound: Int = 60
    
    // Init
    let eventManager = EventManager.init()
    
    // Array that holds event during round
    // var temporaryEventsArrayForRound: [EventManager.Events] = []
    
    // These are the event fields
    // which need to populated with events
    // MARK: - Outlets
    @IBOutlet weak var eventFieldOne: UITextField!
    @IBOutlet weak var eventFieldTwo: UITextField!
    @IBOutlet weak var eventFieldThree: UITextField!
    @IBOutlet weak var eventFieldFour: UITextField!
    
    @IBOutlet weak var DownButtonFieldOne: UIButton!
    @IBOutlet weak var UpButtonFieldTwo: UIButton!
    @IBOutlet weak var DownButtonFieldTwo: UIButton!
    @IBOutlet weak var UpButtonFieldThree: UIButton!
    @IBOutlet weak var DownButtonFieldThree: UIButton!
    @IBOutlet weak var UpButtonFieldFour: UIButton!
    
    // This button needs to be hidden during round
    @IBOutlet weak var NextRoundButton: UIButton!
    
    // This buttond needs to be hidden until game ends
    @IBOutlet weak var NewGameButton: UIButton!
    
    // This is the button that should display timer
    @IBOutlet weak var timeButton: UIButton!
    
    // This is outlet for Label with Shake
    @IBOutlet weak var instructionsLabel: UILabel!
    
    
    // MARK: - Override Functions
    // This makes the ViewController first responder
    // The shake motion can now be detected
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // timeButton.isEnabled = false
        displayEvents()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: - Shake Function
    // In case of shake this updates label
    // Note: In simulator, shake can be accessed by selecting Shake Gesture in Hardware menu
    // When shake is detected checkOrderOfEvents() method get activated
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            checkOrderOfEvents()
            disableUpDownButtons()
            
        }
    }
    
    //MARK: - Disable/Enable Buttons
    func enableUpDownButtons() {
        DownButtonFieldOne.isEnabled = true
        UpButtonFieldTwo.isEnabled = true
        DownButtonFieldTwo.isEnabled = true
        UpButtonFieldThree.isEnabled = true
        DownButtonFieldThree.isEnabled = true
        UpButtonFieldFour.isEnabled = true
    }
    
    func disableUpDownButtons() {
        DownButtonFieldOne.isEnabled = false
        UpButtonFieldTwo.isEnabled = false
        DownButtonFieldTwo.isEnabled = false
        UpButtonFieldThree.isEnabled = false
        DownButtonFieldThree.isEnabled = false
        UpButtonFieldFour.isEnabled = false
    }
    
    // MARK: - Hide
    // This methods hides Buttons and TextFields when score is shown
    // Do I want to hide stuff? This is currently not used
    // and also shows play again button?
    /*
    func hideEventFields() {
        eventFieldOne.isHidden = true
        eventFieldTwo.isHidden = true
        eventFieldThree.isHidden = true
        eventFieldFour.isHidden = true
    }
    */
    
    // MARK: - @IBActions
    // These are the actions that swap field content
    // and position in array
    @IBAction func swapFirstAndSecondEvent(_ sender: UIButton) {
        var fieldOne = eventFieldOne.text
        var fieldTwo = eventFieldTwo.text
        // var eventArrayPositionOne = eventManager.eventsArrayForRound[0]
        // var eventArrayPositionTwo = eventManager.eventsArrayForRound[1]
        // var eventArrayPositionOne = eventManager.temporaryEventsArrayForRound[0]
        // var eventArrayPositionTwo = eventManager.temporaryEventsArrayForRound[1]
        swap(&fieldOne, &fieldTwo)
        //swap(&eventArrayPositionOne, &eventArrayPositionTwo)
        eventFieldOne.text = fieldOne
        eventFieldTwo.text = fieldTwo
        eventManager.eventsArrayForRound.swapAt(0, 1)

        //eventManager.swapEventOneAndTwo()
        // eventFieldOne.text = eventManager.eventsArrayForRound[1].eventName
        // eventFieldTwo.text = eventManager.eventsArrayForRound[0].eventName
        //let updatedEventFieldOneData = eventManager.updateEventForFieldOne()
        //let updatedEventFieldTwoData = eventManager.updateEventForFieldTwo()
        //eventFieldOne.text = updatedEventFieldOneData.eventName
        //eventFieldTwo.text = updatedEventFieldTwoData.eventName
        print(eventManager.eventsArrayForRound)
    }
    
    
    @IBAction func swapSecondAndThirdEvent(_ sender: UIButton) {
        var fieldTwo = eventFieldTwo.text
        var fieldThree = eventFieldThree.text
        //var eventArrayPositionTwo = eventManager.temporaryEventsArrayForRound[1]
        //var eventArrayPositionThree = eventManager.temporaryEventsArrayForRound[2]
        swap(&fieldTwo, &fieldThree)
        //swap(&eventArrayPositionTwo, &eventArrayPositionThree)
        eventFieldTwo.text = fieldTwo
        eventFieldThree.text = fieldThree
        eventManager.eventsArrayForRound.swapAt(1, 2)

        // eventManager.swapEventTwoAndThree()
        print(eventManager.eventsArrayForRound)

    }
    
    
    @IBAction func swapThirdAndFourthEvent(_ sender: UIButton) {
        var fieldThree = eventFieldThree.text
        var fieldFour = eventFieldFour.text
        // var eventArrayPositionThree = eventManager.temporaryEventsArrayForRound[2]
        // var eventArrayPositionFour = eventManager.temporaryEventsArrayForRound[3]
        swap(&fieldThree, &fieldFour)
        // swap(&eventArrayPositionThree, &eventArrayPositionFour)
        eventFieldThree.text = fieldThree
        eventFieldFour.text = fieldFour
        eventManager.eventsArrayForRound.swapAt(2, 3)

        // eventManager.swapEventsThreeAndFour()
        print(eventManager.eventsArrayForRound)

    }
    
    // Needs to load next round when button is clicked
    // Array with eventData for round needs to be emptied when this method is called
    @IBAction func NextRoundButton(_ sender: UIButton) {
        loadNextRound()
        // timeButton.isEnabled = false
    }
    
    // Needs to load new game when button is clicked
    @IBAction func NewGameButton(_ sender: UIButton) {
        eventManager.resetGameData()
    }
    
    
    // MARK: - Display Events
    // This populates the eventFields
    // NewGameButton and NextRoundButton should be hidden
    func displayEvents() {
        enableUpDownButtons()
        instructionsLabel.text = "Shake to check!"
        NewGameButton.isHidden = true
        NextRoundButton.isHidden = true
        // NewGameButton.isEnabled = false
        // let eventFieldData = eventManager.provideEventForFields()
        let eventFieldOneData = eventManager.provideEventForFieldOne()
        let eventFieldTwoData = eventManager.provideEventForFieldTwo()
        let eventFieldThreeData = eventManager.provideEventForFieldThree()
        let eventFieldFourData = eventManager.provideEventForFieldFour()
        eventFieldOne.text = eventFieldOneData.eventName
        eventFieldTwo.text = eventFieldTwoData.eventName
        eventFieldThree.text = eventFieldThreeData.eventName
        eventFieldFour.text = eventFieldFourData.eventName
       
        startTimer()
        // print(temporaryEventsArrayForRound)
    }
    
    // MARK: - Check Order
    // This checks the order of the events
    // Correct: Increases sortedCorrect, increase roundsCompleted
    // Incorrrect: Increase sortedtIncorrect, increase roundsCompleted
    // Empties arrayOfEvents after check
    // Loads and plays sounds
    // endTimer
    func checkOrderOfEvents() { // }-> Bool {
        endTimer()
        // timeButton.setTitle("", for: .normal)
        // timeButton.isEnabled = true
        // var isCorrectOrder = false
        
         if eventManager.eventsArrayForRound[0].eventDate >
            eventManager.eventsArrayForRound[1].eventDate
            &&
            eventManager.eventsArrayForRound[1].eventDate >
            eventManager.eventsArrayForRound[2].eventDate
            &&
            eventManager.eventsArrayForRound[2].eventDate >
            eventManager.eventsArrayForRound[3].eventDate {
            // isCorrectOrder = true
            instructionsLabel.text = "Well done!"
            // If order if correct increases roundsSortedCorrect +1
            eventManager.roundsSortedCorrect += 1
            PlayCorrectDingSound.loadGameCorrectDing()
            PlayCorrectDingSound.playGameCorrectDing()
        } else {
            // If order is wrong roundsSortedIncorrect +1
            instructionsLabel.text = "Woops! Wrong Order"
            // eventManager.roundsSortedIncorrect += 1
            PlayBuzzerSound.loadGameIncorrectBuzz()
            PlayBuzzerSound.playGameIncorrectBuzz()
        }
        // eventManager.currentRound += 1
        endRound()
        // return isCorrectOrder
    }
 
    
    // MARK: - Timer
    
    func startTimer() {
        timerForRound = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    // If secondsPerRound is not equal to 0, then do secondsPerRound - 1
    // If seoncdsPerRound is equal to 0, endTimer & run method: checkOrderEventsMethod
    @objc func updateTime() {
        UIView.setAnimationsEnabled(false)
        timeButton.setTitle("\(displayTime(secondsPerRound))", for: .normal)
        if secondsPerRound != 0 {
            secondsPerRound -= 1
        } else {
            endTimer()
            checkOrderOfEvents()
        }
    }
    
    func displayTime(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds // % 60
        // let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d", seconds)
        // return String(format: "%01d:%02d", minutes, seconds)
    }
    
    func endTimer() {
        timerForRound?.invalidate()
        secondsPerRound = 60
    }
    
    
    // MARK: - Round and Display
    // Needs to display score
    // Needs to hide NextRoundButton when score is displayed
    func displayScore() {
        NextRoundButton.isHidden = true
        NewGameButton.isHidden = false
        instructionsLabel.text = "\(eventManager.roundsSortedCorrect) out of \(eventManager.roundsPerGame) sorted correct\nPress button to play again."
    }
    
    // When round ends show next round button
    // Exceeds: Show ?-Buttons to call wiki Events
    func endRound() {
        eventManager.roundsCompleted += 1
        eventManager.eventsArrayForRound.removeAll()
        NextRoundButton.isHidden = false
    }
    
    // This loads next round of Event if roundsPerGame != 6
    func loadNextRound() {
        if eventManager.roundsCompleted < eventManager.roundsPerGame {
            displayEvents()
        } else {
            displayScore()
        }
    }

}


