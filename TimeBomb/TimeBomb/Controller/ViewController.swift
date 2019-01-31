//
//  ViewController.swift
//  TimeBomb
//
//  Created by Wouter Willebrands on 08/01/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit



@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}


@IBDesignable class ButtonWithoutClipping: UIButton {
    
    @IBInspectable var masksToBounds: Bool = true
    
    func updateLayerProperties() {
        self.layer.masksToBounds = true
    }
}


    
class ViewController: UIViewController {
    // This needs to display correctly on iPhone screen sies of 4.7 and 5.5 inches
    
    // These are the event fields
    // which need to populated with events
    @IBOutlet weak var eventFieldOne: UITextField!
    @IBOutlet weak var eventFieldTwo: UITextField!
    @IBOutlet weak var eventFieldThree: UITextField!
    @IBOutlet weak var eventFieldFour: UITextField!
    
    
    // This methods hides Buttons and TextFields when score is shown
    // and also shows play again button?
    func hideSomeButtonsAndOrTextFields() {
        eventFieldOne.isHidden = true
        eventFieldTwo.isHidden = true
        eventFieldThree.isHidden = true
        eventFieldFour.isHidden = true
    }
    
    // These are the buttons that swap field content
    // With either the label above or below
    // MARK: - SWAP (Check if content is properly swapped)
    // Use the Array form EventManager to store values
    // and then swap content with these
    @IBAction func swapFirstAndSecond(_ sender: UIButton) {
        var fieldOne = eventFieldOne.text
        var fieldTwo = eventFieldTwo.text
        swap(&fieldOne, &fieldTwo)
        eventFieldOne.text = fieldOne
        eventFieldTwo.text = fieldTwo
        
    }
    
    
    @IBAction func swapSecondAndThird(_ sender: UIButton) {
        var fieldTwo = eventFieldTwo.text
        var fieldThree = eventFieldThree.text
        swap(&fieldTwo, &fieldThree)
        eventFieldTwo.text = fieldTwo
        eventFieldThree.text = fieldThree
    }
    
    
    @IBAction func swapThirdAndFourth(_ sender: UIButton) {
        var fieldThree = eventFieldThree.text
        var fieldFour = eventFieldFour.text
        swap(&fieldThree, &fieldFour)
        eventFieldThree.text = fieldThree
        eventFieldFour.text = fieldFour
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayEvents()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    let eventManager = EventManager.init()
    
    // This method properly displays a random event
    // In each of the four eventFields without repetition
    
    // MARK: - EVENTFIELDS (Refactor: combine these -> DRY!)
    func displayEvents() {
        let eventFieldOneData = eventManager.provideEventForFieldOne()
        let eventFieldTwoData = eventManager.provideEventForFieldTwo()
        let eventFieldThreeData = eventManager.provideEventForFieldThree()
        let eventFieldFourData = eventManager.provideEventForFieldFour()
        eventFieldOne.text = eventFieldOneData.eventName
        eventFieldTwo.text = eventFieldTwoData.eventName
        eventFieldThree.text = eventFieldThreeData.eventName
        eventFieldFour.text = eventFieldFourData.eventName
    }
    
    // This checks the order of the events and increases score if in right order
    // Check eventDate integers for each textField
    // https://stackoverflow.com/questions/24602595/extending-array-to-check-if-it-is-sorted-in-swift
    // link above could provide solution
    // If eventData integer for textfield 1 > 2 > 3 > 4 then events are in right order
    // else: not
    // play sounds
    // If correct order of events increase roundsSortedCorrectly by 1
    // After each round increase roundsCompleted by 1
    static func checkOrderOfEvents() {
        // var eventsToCheckForOrder = eventFieldOne, eventFieldTwo, eventFieldThree, eventFieldFour
        
        
        
    }
    
    // Needs to display score
    // Needs to hide some stuff when score is displayed
    func displayScore() {
        
    }
    
    // Needs to end round
    // when device is shaken
    // OR
    // when timer runs out
    func endRound() {
        
    }
    
    // Needs to load next round when button is clicked
    // Array with eventData for round needs to be emptied when this method is called
    // This will likely be a Button action
    func loadNextRound() {
        
    }
    
    // Needs to load new game when button is clicked
    func loadNewGame() {
        
        
        
    }

}


