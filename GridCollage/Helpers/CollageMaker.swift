//
//  CollageMaker.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 10/11/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation
import UIKit

class CollageMaker {
    
    static func make(imageTL: UIImage,
              imageTR: UIImage,
              imageBL: UIImage,
              imageBR: UIImage) -> UIImage? {
        
        let imageWidth = min(imageTL.size.width, imageTR.size.width, imageBL.size.width, imageBR.size.width)
        let imageHeight = min(imageTL.size.height, imageTR.size.height, imageBL.size.height, imageBR.size.height)
        
        let newImageWidth = imageWidth * 2
        let newImageHeight = imageHeight * 2
        let newImageSize = CGSize(width : newImageWidth, height: newImageHeight)
        
        UIGraphicsBeginImageContextWithOptions(newImageSize, false, UIScreen.main.scale)
        
        let center = CGPoint(x: imageWidth, y: imageHeight)
        
        imageTL.draw(at: CGPoint(x: 0, y: 0))
        imageTR.draw(at: CGPoint(x: center.x, y: 0))
        imageBL.draw(at: CGPoint(x: 0, y: center.y))
        imageBR.draw(at: CGPoint(x: center.x, y: center.y))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
