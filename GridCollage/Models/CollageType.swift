//
//  CollageType.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 14/11/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation

enum CollageType: Int, CaseIterable {
    /*
     [][]
     [][]
     */
    case regularGrid = 0
    
    /*
     []
     []
     []
     []
     */
    case verticalStack = 1
    
    /*
     [][][][]
     */
    case horizontalStack = 2
    
}
