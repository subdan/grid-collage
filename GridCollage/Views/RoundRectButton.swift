//
//  RoundRectButton.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 10/11/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation
import UIKit

class RoundRectButton: UIButton {
    
    private var normalColor = UIColor.lightGray
    private var highlightedColor = UIColor.darkGray
    
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? highlightedColor : normalColor
        }
    }
    
    func setBackgroundColor(_ color: UIColor, for state: UIButton.State) {
        switch state {
        case UIButton.State.highlighted:
            highlightedColor = color
        default:
            normalColor = color
            backgroundColor = color
        }
    }
}
