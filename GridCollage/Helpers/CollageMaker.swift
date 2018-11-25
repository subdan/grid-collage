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
    
    static func makeCollage(ofType type: CollageType, from images: [UIImage]) -> UIImage? {
        if type == .regularGrid {
            return makeGridCollage(images)
        } else if type == .horizontalStack {
            return makeHorizontalStackCollage(images)
        } else {
            return makeVerticalStackCollage(images)
        }
    }
    
    private static func makeGridCollage(_ images: [UIImage]) -> UIImage? {
        let imageTL = images[0]
        let imageTR = images[1]
        let imageBL = images[2]
        let imageBR = images[3]
        
        let imageWidth = min(imageTL.size.width, imageTR.size.width, imageBL.size.width, imageBR.size.width)
        let imageHeight = min(imageTL.size.height, imageTR.size.height, imageBL.size.height, imageBR.size.height)
        
        let newImageWidth = imageWidth * 2
        let newImageHeight = imageHeight * 2
        let newImageSize = CGSize(width: newImageWidth, height: newImageHeight)
        UIGraphicsBeginImageContextWithOptions(newImageSize, false, UIScreen.main.scale)
        
        var targetRect = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        imageTL.draw(in: targetRect)
        
        targetRect = CGRect(x: imageWidth, y: 0, width: imageWidth, height: imageHeight)
        imageTR.draw(in: targetRect)
        
        targetRect = CGRect(x: 0, y: imageHeight, width: imageWidth, height: imageHeight)
        imageBL.draw(in: targetRect)
        
        targetRect = CGRect(x: imageHeight, y: imageHeight, width: imageWidth, height: imageHeight)
        imageBR.draw(in: targetRect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    private static func makeHorizontalStackCollage(_ images: [UIImage]) -> UIImage? {
        let image1 = images[0]
        let image2 = images[1]
        let image3 = images[2]
        let image4 = images[3]
        
        let oneImageWidth = min(image1.size.width, image2.size.width, image3.size.width, image4.size.width)
        let oneImageHeight = oneImageWidth / 4
        
        let resultImageWidth = oneImageWidth
        let resultImageHeight = oneImageWidth
        let newImageSize = CGSize(width : resultImageWidth, height: resultImageHeight)
        
        UIGraphicsBeginImageContextWithOptions(newImageSize, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        context.saveGState()
        var targetRect = CGRect(x: 0,
                                y: -(resultImageHeight - oneImageHeight)/2,
                                width: resultImageWidth,
                                height: resultImageHeight)
        
        var path = CGPath(rect: CGRect(x: 0, y: 0, width: oneImageWidth, height: oneImageHeight), transform: nil)
        context.addPath(path)
        context.clip()
        image1.draw(in: targetRect)
        context.restoreGState()
        
        context.saveGState()
        targetRect = CGRect(x: 0,
                            y: oneImageHeight - (resultImageHeight - oneImageHeight)/2,
                            width: resultImageWidth,
                            height: resultImageHeight)
        path = CGPath(rect: CGRect(x: 0, y: oneImageHeight, width: oneImageWidth, height: oneImageHeight), transform: nil)
        context.addPath(path)
        context.clip()
        image2.draw(in: targetRect)
        context.restoreGState()
        
        context.saveGState()
        targetRect = CGRect(x: 0,
                            y: oneImageHeight * 2 - (resultImageHeight - oneImageHeight)/2,
                            width: resultImageWidth,
                            height: resultImageHeight)
        path = CGPath(rect: CGRect(x: 0, y: oneImageHeight * 2, width: oneImageWidth, height: oneImageHeight), transform: nil)
        context.addPath(path)
        context.clip()
        image3.draw(in: targetRect)
        context.restoreGState()
        
        context.saveGState()
        targetRect = CGRect(x: 0,
                            y: oneImageHeight * 3 - (resultImageHeight - oneImageHeight)/2,
                            width: resultImageWidth,
                            height: resultImageHeight)
        path = CGPath(rect: CGRect(x: 0, y: oneImageHeight * 3, width: oneImageWidth, height: oneImageHeight), transform: nil)
        context.addPath(path)
        context.clip()
        image4.draw(in: targetRect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    private static func makeVerticalStackCollage(_ images: [UIImage]) -> UIImage? {
        let image1 = images[0]
        let image2 = images[1]
        let image3 = images[2]
        let image4 = images[3]
        
        let oneImageHeight = min(image1.size.height, image2.size.height, image3.size.height, image4.size.height)
        let oneImageWidth = oneImageHeight / 4
        
        let resultImageWidth = oneImageHeight
        let resultImageHeight = oneImageHeight
        let newImageSize = CGSize(width : resultImageWidth, height: resultImageHeight)
        
        UIGraphicsBeginImageContextWithOptions(newImageSize, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        context.saveGState()
        var targetRect = CGRect(x: -(resultImageWidth - oneImageWidth)/2,
                                y: 0,
                                width: resultImageWidth,
                                height: resultImageHeight)
        
        var path = CGPath(rect: CGRect(x: 0, y: 0, width: oneImageWidth, height: oneImageHeight), transform: nil)
        context.addPath(path)
        context.clip()
        image1.draw(in: targetRect)
        context.restoreGState()
        
        context.saveGState()
        targetRect = CGRect(x: oneImageWidth - (resultImageWidth - oneImageWidth)/2,
                            y: 0,
                            width: resultImageWidth,
                            height: resultImageHeight)
        path = CGPath(rect: CGRect(x: oneImageWidth, y: 0, width: oneImageWidth, height: oneImageHeight), transform: nil)
        context.addPath(path)
        context.clip()
        image2.draw(in: targetRect)
        context.restoreGState()

        context.saveGState()
        targetRect = CGRect(x: oneImageWidth * 2 - (resultImageWidth - oneImageWidth)/2,
                            y: 0,
                            width: resultImageWidth,
                            height: resultImageHeight)
        path = CGPath(rect: CGRect(x: oneImageWidth * 2, y: 0, width: oneImageWidth, height: oneImageHeight), transform: nil)
        context.addPath(path)
        context.clip()
        image3.draw(in: targetRect)
        context.restoreGState()

        context.saveGState()
        targetRect = CGRect(x: oneImageWidth * 3 - (resultImageWidth - oneImageWidth)/2,
                            y: 0,
                            width: resultImageWidth,
                            height: resultImageHeight)
        path = CGPath(rect: CGRect(x: oneImageWidth * 3, y: 0, width: oneImageWidth, height: oneImageHeight), transform: nil)
        context.addPath(path)
        context.clip()
        image4.draw(in: targetRect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
