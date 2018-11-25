//
//  CreateCollageButton.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 28/10/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import UIKit

class CreateCollageButton: UIButton {

    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? #colorLiteral(red: 0.1726666667, green: 0.4655833333, blue: 0.74, alpha: 1) : #colorLiteral(red: 0.2196078431, green: 0.5921568627, blue: 0.9411764706, alpha: 1)
        }
    }
    
    override open var isEnabled: Bool {
        didSet {
            layer.opacity = isEnabled ? 1.0 : 0.5
        }
    }

}
