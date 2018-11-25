//
//  HorizontalStackCollageCell.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 14/11/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation
import UIKit

class HorizontalStackCollageCell: StackCollageCell {
    
    lazy var backgoundImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "stack_horizontal"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    class var reuseId: String {
        return "horizontal_stack_collage_cell"
    }
    
    override func setupView() {
        addSubview(backgoundImage)
        super.setupView()
        
        stackView.axis = NSLayoutConstraint.Axis.vertical
        
        let margins = layoutMarginsGuide
        NSLayoutConstraint.activate([
            backgoundImage.leftAnchor.constraint(equalTo: margins.leftAnchor),
            backgoundImage.rightAnchor.constraint(equalTo: margins.rightAnchor),
            backgoundImage.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            backgoundImage.topAnchor.constraint(equalTo: margins.topAnchor)
        ])
    }
}
