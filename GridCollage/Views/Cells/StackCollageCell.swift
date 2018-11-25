//
//  StackCollageCell.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 14/11/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation
import UIKit

class StackCollageCell: CollageCell {
   
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = UIColor.green
        view.distribution = .fillEqually
        view.spacing = 0
        view.backgroundColor = UIColor.yellow
        view.axis = NSLayoutConstraint.Axis.vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupView() {
        addSubview(stackView)
        
        image1.clipsToBounds = true
        image2.clipsToBounds = true
        image3.clipsToBounds = true
        image4.clipsToBounds = true
        
        image1.contentMode = .scaleAspectFill
        image2.contentMode = .scaleAspectFill
        image3.contentMode = .scaleAspectFill
        image4.contentMode = .scaleAspectFill
        
        stackView.addArrangedSubview(image1)
        stackView.addArrangedSubview(image2)
        stackView.addArrangedSubview(image3)
        stackView.addArrangedSubview(image4)
        
        let margins = layoutMarginsGuide
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: margins.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: margins.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: margins.topAnchor)
        ])
    }
}
