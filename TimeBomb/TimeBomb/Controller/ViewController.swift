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
    var timerForRound: Timer!
    
    var secondsPerRound: Int = 60
    
    // Init
    let eventManager = EventManager.init()
    
    
    
    
    // MARK: - Outlets
    // These are the eventFields
    @IBOutlet weak var eventFieldOne: UITextField!
    @IBOutlet weak var eventFieldTwo: UITextField!
    @IBOutlet weak var eventFieldThree: UITextField!
    @IBOutlet weak var eventFieldFour: UITextField!
    
    // These are the up/downButtons for the eventFields
    @IBOutlet weak var downButtonFieldOne: UIButton!
    @IBOutlet weak var upButtonFieldTwo: UIButton!
    @IBOutlet weak var downButtonFieldTwo: UIButton!
    @IBOutlet weak var upButtonFieldThree: UIButton!
    @IBOutlet weak var downButtonFieldThree: UIButton!
    @IBOutlet weak var upButtonFieldFour: UIButton!
    
    // This button needs to be hidden during round
    @IBOutlet weak var nextRoundButton: UIButton!
    
    // This buttond needs to be hidden until game ends
    @IBOutlet weak var newGameButton: UIButton!
    
    // This is the button that displays timer
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
        
        displayEvents()
    }
    
    // MARK: - Shake Function
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            endTimer()
            changeLabelText()
            disableUpDownButtons()
            showNextRoundButtonOrDisplayScore()
        }
    }
    
    //MARK: - Disable/Enable Buttons
    func enableUpDownButtons() {
        downButtonFieldOne.isEnabled = true
        upButtonFieldTwo.isEnabled = true
        downButtonFieldTwo.isEnabled = true
        upButtonFieldThree.isEnabled = true
        downButtonFieldThree.isEnabled = true
        upButtonFieldFour.isEnabled = true
    }
    
    func disableUpDownButtons() {
        downButtonFieldOne.isEnabled = false
        upButtonFieldTwo.isEnabled = false
        downButtonFieldTwo.isEnabled = false
        upButtonFieldThree.isEnabled = false
        downButtonFieldThree.isEnabled = false
        upButtonFieldFour.isEnabled = false
    }
    
    // MARK: - @IBActions
    // These are the actions that swap field content
    // and position in array
    @IBAction func swapFirstAndSecondEvent(_ sender: UIButton) {
        var fieldOne = eventFieldOne.text
        var fieldTwo = eventFieldTwo.text
        swap(&fieldOne, &fieldTwo)
        eventFieldOne.text = fieldOne
        eventFieldTwo.text = fieldTwo
        eventManager.eventsArrayForRound.swapAt(0, 1)
    }
    
    
    @IBAction func swapSecondAndThirdEvent(_ sender: UIButton) {
        var fieldTwo = eventFieldTwo.text
        var fieldThree = eventFieldThree.text
        swap(&fieldTwo, &fieldThree)
        eventFieldTwo.text = fieldTwo
        eventFieldThree.text = fieldThree
        eventManager.eventsArrayForRound.swapAt(1, 2)
    }
    
    
    @IBAction func swapThirdAndFourthEvent(_ sender: UIButton) {
        var fieldThree = eventFieldThree.text
        var fieldFour = eventFieldFour.text
        swap(&fieldThree, &fieldFour)
        eventFieldThree.text = fieldThree
        eventFieldFour.text = fieldFour
        eventManager.eventsArrayForRound.swapAt(2, 3)
    }
    
    // Needs to load next round when button is clicked
    // Array with eventData for round needs to be emptied when this method is called
    @IBAction func nextRoundButton(_ sender: UIButton) {
        displayEvents()
    }
    
    // Needs to reset all game when button is clicked
    @IBAction func newGameButton(_ sender: UIButton) {
        timeButton.isHidden = false
        eventManager.resetGameData()
        displayEvents()
    }
    
    
    // MARK: - Display Events
    // This populates the eventFields
    // NewGameButton and NextRoundButton should be hidden
    func displayEvents() {
        eventManager.eventArrayProvider()
        enableUpDownButtons()
        startTimer()
        instructionsLabel.text = "Shake to check!"
        
        newGameButton.isHidden = true
        nextRoundButton.isHidden = true

        let eventFieldData = eventManager.eventsArrayForRound

        eventFieldOne.text = eventFieldData[0].eventName
        eventFieldTwo.text = eventFieldData[1].eventName
        eventFieldThree.text = eventFieldData[2].eventName
        eventFieldFour.text = eventFieldData[3].eventName
       
    }
    
    func changeLabelText() {
        let variable = eventManager.isOrderOfEventsCorrect()
        
        if variable == true {
            instructionsLabel.text = "Well done!"
        } else {
            instructionsLabel.text = "Woops! Wrong Order"
        }
    }
  
    
    // MARK: - Timer
    func startTimer() {
        timerForRound = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        timeButton.setTitle("\((secondsPerRound))", for: .normal)
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
            changeLabelText()
            showNextRoundButtonOrDisplayScore()
        }
    }
    
    func displayTime(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds
        return String(format: "%02d", seconds)
    }
    
    func endTimer() {
        timerForRound.invalidate()
        secondsPerRound = 60
    }
    
    
    // MARK: - Display Score
    // Hides nextRoundButton when score is displayed and show newGameButton
    // Changes instruction label to display score
    func displayScore() {
        nextRoundButton.isHidden = true
        newGameButton.isHidden = false
        timeButton.isHidden = true
        instructionsLabel.text = "\(eventManager.roundsSortedCorrect) out of \(eventManager.roundsPerGame) sorted correct\nPress New Game to play again."
    }
    
    // MARK: - Next Round or Score
    func showNextRoundButtonOrDisplayScore() {
        if eventManager.roundsCompleted < eventManager.roundsPerGame {
            nextRoundButton.isHidden = false
        } else {
            displayScore()
        }
    }

}


