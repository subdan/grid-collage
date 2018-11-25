//
//  VerticalStackCollageCell.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 14/11/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation
import UIKit

class VerticalStackCollageCell: StackCollageCell {
    
    lazy var backgoundImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "stack_vertical"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    class var reuseId: String {
        return "vertical_stack_collage_cell"
    }
    
    override func setupView() {
        addSubview(backgoundImage)
        super.setupView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        let margins = layoutMarginsGuide
        NSLayoutConstraint.activate([
            backgoundImage.leftAnchor.constraint(equalTo: margins.leftAnchor),
            backgoundImage.rightAnchor.constraint(equalTo: margins.rightAnchor),
            backgoundImage.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            backgoundImage.topAnchor.constraint(equalTo: margins.topAnchor)
        ])
    }
}
