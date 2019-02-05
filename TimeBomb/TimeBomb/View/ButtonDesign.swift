//
//  RoundButton.swift
//  TimeBomb
//
//  Created by Wouter Willebrands on 30/01/2019.
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
            layer.masksToBounds = true
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

/*


@IBDesignable class ButtonWithoutClipping: UIButton {
    
    @IBInspectable var masksToBounds: Bool = true
    
    func updateLayerProperties() {
        self.layer.masksToBounds = true
    }
}



import Foundation
import UIKit

@IBInspectable var cornerRadius: CGFloat = 15 {
    didSet {
        refreshCorners(value: cornerRadius)
    }
}

@IBDesignable class RoundButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        // Common logic goes here
    }
}


func refreshCorners(value: CGFloat) {
    layer.cornerRadius = value
}

func sharedInit() {
    refreshCorners(value: cornerRadius)
}

 */
