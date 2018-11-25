//
//  CollageItemViewModel.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 10/11/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation

class CollageItemViewModel {
    let instaImage: InstaImage
    let position: Int
    
    init(instaImage: InstaImage, position: Int) {
        self.instaImage = instaImage
        self.position = position
    }
}
