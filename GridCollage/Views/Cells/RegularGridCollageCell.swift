//
//  RegularGridCollageCell.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 11/11/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class RegularGridCollageCell: CollageCell {
    
    lazy var backgoundImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "grid"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    class var reuseId: String {
        return "grid_collage_cell"
    }

    override func setupView() {
        addSubview(backgoundImage)
        addSubview(image1)
        addSubview(image2)
        addSubview(image3)
        addSubview(image4)
        
        let margins = layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            backgoundImage.leftAnchor.constraint(equalTo: margins.leftAnchor),
            backgoundImage.rightAnchor.constraint(equalTo: margins.rightAnchor),
            backgoundImage.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            backgoundImage.topAnchor.constraint(equalTo: margins.topAnchor),
            
            image1.leftAnchor.constraint(equalTo: margins.leftAnchor),
            image3.leftAnchor.constraint(equalTo: margins.leftAnchor),
            image2.rightAnchor.constraint(equalTo: margins.rightAnchor),
            image4.rightAnchor.constraint(equalTo: margins.rightAnchor),
            
            image1.topAnchor.constraint(equalTo: margins.topAnchor),
            image3.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            image2.topAnchor.constraint(equalTo: margins.topAnchor),
            image4.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            
            image1.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.5),
            image3.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.5),
            image2.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.5),
            image4.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.5),
            
            image1.heightAnchor.constraint(equalTo: image1.widthAnchor),
            image3.heightAnchor.constraint(equalTo: image3.widthAnchor),
            image2.heightAnchor.constraint(equalTo: image2.widthAnchor),
            image4.heightAnchor.constraint(equalTo: image4.widthAnchor)
        ])
    }
    
}
